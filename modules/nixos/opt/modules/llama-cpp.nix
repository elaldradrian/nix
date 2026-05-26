{
  lib,
  pkgs,
  ...
}:
let
  llama-pkgs =
    let
      newSrc = pkgs.llama-cpp.src.override {
        tag = "b9496";
        hash = "sha256-1jAowfGVzrrHDwWWzKESY7aV82whnuIg1N37fmtcgyw=";
      };
    in
    (pkgs.llama-cpp.override {
      vulkanSupport = true;
      rocmSupport = true;
    }).overrideAttrs
      (prev: {
        version = "9496";
        npmRoot = "tools/ui";
        src = newSrc;
        npmDeps = pkgs.fetchNpmDeps {
          name = "llama-cpp-9496-npm-deps";
          inherit (prev) patches;
          src = newSrc;
          preBuild = ''
            pushd tools/ui
          '';
          hash = "sha256-1iM0LGeI9e+gZEHk46lkBe51DxIhiimfAm9o3Z3m9Ik=";
        };
      });

  llama-server = "${llama-pkgs}/bin/llama-server";

  modelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { } {
      "qwen3.6-27b" = {
        model = "/var/lib/llama/models/Qwen3.6-27B-Q6_K.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "30";
        cache-ram = "30000";
        ctx-size = "190000";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        ngl = 99;
        fit = "off";
        keep = "-1";
        min-p = "0.00";
        no-mmap = "true";
        parallel = "2";
        presence-penalty = "0";
        repeat-penalty = "1";
        temp = "0.6";
        top-k = "20";
        top-p = "0.95";
        batch-size = "2048";
        ubatch-size = "512";
        spec-type = "draft-mtp";
        spec-draft-n-max = "2";
        no-mmproj-offload = "true";
        device = "Vulkan0";
      };
      "qwen3.6-35b-a3b" = {
        model = "/var/lib/llama/models/Qwen3.6-35B-A3B-UD-Q5_K_XL.gguf";
        jinja = "true";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "30";
        cache-ram = "25000";
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
        spec-type = "draft-mtp";
        no-mmproj-offload = "true";
        device = "Vulkan0";
      };
    }
  );

  run-llama-cpp = pkgs.writeShellScript "run-llama-cpp" ''
    exec ${llama-server} \
      --host 0.0.0.0 --port 11434 \
      --models-preset ${modelsIni} --models-max 1 \
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

  environment.systemPackages = [ llama-pkgs ];
}
