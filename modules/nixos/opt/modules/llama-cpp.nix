{
  lib,
  pkgs,
  config,
  ...
}:
let
  llama-pkgs = (
    (pkgs.llama-cpp.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages_13_1;
      rocmSupport = true;
    }).overrideAttrs
      (prev: {
        version = "8967";
        src = prev.src.override {
          tag = "b8967";
          hash = "sha256-cWLFZV5JrmeS/1+CoBDHnviG1MuuUpw4m1H4vS+z9dU=";
        };
        npmDeps = pkgs.fetchNpmDeps {
          name = "llama-cpp-8884-npm-deps";
          inherit (prev) patches;
          src = prev.src.override {
            tag = "b8967";
            hash = "sha256-cWLFZV5JrmeS/1+CoBDHnviG1MuuUpw4m1H4vS+z9dU=";
          };
          preBuild = "pushd tools/server/webui";
          hash = "sha256-iYJB0z2YHG8OzEA9EwHUZrDa5obr5m2sbnIH+of28o0=";
        };
      })
  );

  llama-server = "${llama-pkgs}/bin/llama-server";

  modelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { listsAsDuplicateKeys = true; } {
      "qwen3.6-27b" = {
        model = "/var/lib/llama/Qwen3.6-27B-Q4_K_M.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "1";
        ctx-size = "5000";
        fit-target = "1024";
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
        ubatch-size = "2048";
      };
      "qwen3.6-35b-a3b" = {
        model = "/var/lib/llama/models/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "64";
        checkpoint-every-n-tokens = "2048";
        cache-ram = "24576";
        ctx-size = "131072";
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
        batch-size = "2048";
        ubatch-size = "2048";
        device = "Cuda0";
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
    description = "llama.cpp server (models.ini)";
    after = [ "network.target" ];
    wants = [ "network.target" ];

    serviceConfig = {
      ExecStart = "${run-llama-cpp}";
      Restart = "on-failure";
      LimitMEMLOCK = "infinity";
      Type = "simple";
      User = "_llama-cpp";
      Group = "_llama-cpp";
      DynamicUser = false;
      ReadWritePaths = [ "/home/rune/models" ];
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
