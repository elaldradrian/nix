{
  lib,
  pkgs,
  config,
  ...
}:
let
  pr22673Src = pkgs.fetchFromGitHub {
    owner = "am17an";
    repo = "llama.cpp";
    rev = "5d5f1b46e4f56885801c86363d4677a5f72f83af";
    hash = "sha256-2/3vfOqySdpM4vVvG+a0Tj0Fwi8dCy3KV3+JmdgOcs4=";
  };

  llama-pkgs = (
    (pkgs.llama-cpp.override {
      vulkanSupport = true;
    }).overrideAttrs
      (prev: {
        version = "22673";
        src = pr22673Src;
        npmDeps = pkgs.fetchNpmDeps {
          name = "llama-cpp-22673-npm-deps";
          inherit (prev) patches;
          src = pr22673Src;
          preBuild = "pushd tools/server/webui";
          hash = "sha256-k62LIbyY2DXvs7XXbX0lNPiYxuYzeJUyQtS4eA+68f8=";
        };
      })
  );

  # Upstream
  # llama-pkgs = (
  #   (pkgs.llama-cpp.override {
  #     vulkanSupport = true;
  #     rocmSupport = true;
  #   }).overrideAttrs
  #     (prev: {
  #       version = "9045";
  #       src = prev.src.override {
  #         tag = "b9045";
  #         hash = "sha256-fdHGxJaMx/VG7twXdWvHdkThAOSFJTbjAnpRxsNx5l0=";
  #       };
  #       npmDeps = pkgs.fetchNpmDeps {
  #         name = "llama-cpp-9045-npm-deps";
  #         inherit (prev) patches;
  #         src = prev.src.override {
  #           tag = "b9045";
  #           hash = "sha256-fdHGxJaMx/VG7twXdWvHdkThAOSFJTbjAnpRxsNx5l0=";
  #         };
  #         preBuild = "pushd tools/server/webui";
  #         hash = "sha256-k62LIbyY2DXvs7XXbX0lNPiYxuYzeJUyQtS4eA+68f8=";
  #       };
  #     })
  # );

  llama-server = "${llama-pkgs}/bin/llama-server";

  modelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { } {
      "qwen3.6-27b" = {
        model = "/var/lib/llama/models/Qwen3.6-27B-MTP-UD-Q5_K_XL.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "80";
        checkpoint-every-n-tokens = "6144";
        cache-ram = "45000";
        # ctx-size = "140000";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        ngl = 99;
        fit = "off";
        keep = "-1";
        min-p = "0.00";
        no-mmap = "true";
        parallel = "1";
        presence-penalty = "0";
        repeat-penalty = "1";
        temp = "0.6";
        top-k = "20";
        top-p = "0.95";
        batch-size = "2048";
        ubatch-size = "512";
        spec-type = "mtp";
        spec-draft-n-max = "2";
        no-mmproj-offload = "true";
        device = "Vulkan0";
      };
      "qwen3.6-35b-a3b" = {
        model = "/var/lib/llama/models/Qwen3.6-35B-A3B-UD-Q5_K_XL.gguf";
        jinja = "true";
        # ctx-size = "150000";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "80";
        checkpoint-every-n-tokens = "6144";
        cache-ram = "50000";
        fit = "off";
        ngl = 99;
        keep = "-1";
        min-p = "0.00";
        no-mmap = "true";
        parallel = "1";
        presence-penalty = "0";
        repeat-penalty = "1";
        temp = "0.6";
        top-k = "20";
        top-p = "0.95";
        batch-size = "4096";
        ubatch-size = "2048";
        spec-type = "ngram-mod";
        no-mmproj-offload = "true";
        device = "Vulkan0";
      };
    }
  );

  run-llama-cpp = pkgs.writeShellScript "run-llama-cpp" ''
    exec ${llama-server} \
      --host 0.0.0.0 --port 11434 \
      --models-preset ${modelsIni} --models-max 1 \
      --api-key-file ${config.sops.secrets.llama-cpp-api-key.path} \
      --metrics
  '';

in
{
  systemd.services.llama-cpp = {
    enable = true;
    description = "llama.cpp server (models.ini)";
    after = [ "network.target" ];
    wants = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${run-llama-cpp}";
      Restart = "on-failure";
      LimitMEMLOCK = "infinity";
      Type = "simple";
      User = "_llama-cpp";
      Group = "_llama-cpp";
      DynamicUser = false;
      ReadWritePaths = [ "/var/lib/llama/models/" ];
      StandardOutput = "journal";
      StandardError = "journal";
    };

    preStart = ''
      useradd -r -s /usr/bin/nologin -d /var/lib/llama-cpp _llama-cpp 2>/dev/null || true
    '';
  };

  users.users._llama-cpp = {
    isSystemUser = true;
    group = "_llama-cpp";
  };
  users.groups._llama-cpp = { };

  sops.secrets.llama-cpp-api-key = {
    owner = "_llama-cpp";
    group = "prometheus";
    mode = "0440";
    restartUnits = [
      "llama-cpp.service"
      "prometheus.service"
      "llama-model-sd.service"
    ];
  };

  environment.systemPackages = [ llama-pkgs ];
}
