{
  lib,
  pkgs,
  config,
  ...
}:
let
  llama-pkgs = (
    (pkgs.llama-cpp.override {
      vulkanSupport = true;
    }).overrideAttrs
      (prev: {
        version = "9012";
        src = prev.src.override {
          tag = "b9012";
          hash = "sha256-NSMFAOyBIlJbiYXmQdkvhw3yDYY4nq7tS+3BmjP0NTM=";
        };
        npmDeps = pkgs.fetchNpmDeps {
          name = "llama-cpp-9012-npm-deps";
          inherit (prev) patches;
          src = prev.src.override {
            tag = "b9012";
            hash = "sha256-NSMFAOyBIlJbiYXmQdkvhw3yDYY4nq7tS+3BmjP0NTM=";
          };
          preBuild = "pushd tools/server/webui";
          hash = "sha256-k62LIbyY2DXvs7XXbX0lNPiYxuYzeJUyQtS4eA+68f8=";
        };
      })
  );

  llama-server = "${llama-pkgs}/bin/llama-server";

  modelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { } {
      "qwen3.6-27b" = {
        model = "/var/lib/llama/models/Qwen3.6-27B-UD-Q5_K_XL.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "80";
        checkpoint-every-n-tokens = "4096";
        cache-ram = "32768";
        ctx-size = "200000";
        fit-target = "512";
        fit = "on";
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
        spec-type = "ngram-mod";
        no-mmproj-offload = "true";
        device = "Vulkan0";
      };
      "qwen3.6-35b-a3b" = {
        model = "/var/lib/llama/models/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "80";
        checkpoint-every-n-tokens = "4096";
        cache-ram = "32768";
        fit-target = "256";
        fit = "on";
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
      --api-key-file ${config.sops.secrets.llama-cpp-api-key.path}
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
    group = "_llama-cpp";
    mode = "0400";
    restartUnits = [ "llama-cpp.service" ];
  };

  environment.systemPackages = [ llama-pkgs ];
}
