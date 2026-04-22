{
  pkgs,
  lib,
  config,
  gpuBackend,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  llama-pkgs = pkgs.llama-cpp.override {
    rpcSupport = true;
    cudaSupport = gpuBackend == "nvidia";
    cudaPackages = pkgs.cudaPackages_12_8;
    vulkanSupport = gpuBackend == "vulkan";
  };

  llama-server = "${llama-pkgs}/bin/llama-server";

  darwinModelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { } {
      "" = {
        version = "1";
      };
      "qwen3.6-35b-a3b" = {
        model = "/Users/rdb/models/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
        jinja = "true";
        c = "65536";
        ctx-checkpoints = "1";
        no-warmup = "true";
        cache-ram = "0";
        parallel = "1";
        keep = "-1";
        temp = "0.6";
        top-p = "0.95";
        top-k = "20";
        min-p = "0.00";
        presence-penalty = "0";
        repeat-penalty = "1";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
      };
      "qwen3.5-27b" = {
        model = "/Users/rdb/models/Qwen3.5-27B-UD-Q4_K_XL.gguf";
        jinja = "true";
        c = "65536";
        ctx-checkpoints = "1";
        no-warmup = "true";
        cache-ram = "0";
        parallel = "1";
        keep = "-1";
        temp = "0.6";
        top-p = "0.95";
        top-k = "20";
        min-p = "0.00";
        presence-penalty = "0";
      };
      "gemma-4-26b-a4b" = {
        model = "/Users/rdb/models/gemma-4-26B-A4B-it-UD-Q4_K_XL.gguf";
        jinja = "true";
        c = "65536";
        ctx-checkpoints = "1";
        no-warmup = "true";
        cache-ram = "0";
        parallel = "1";
        keep = "-1";
        temp = "1";
        top-p = "0.95";
        top-k = "64";
      };
      "gemma-4-31b" = {
        model = "/Users/rdb/models/gemma-4-31B-it-UD-Q4_K_XL.gguf";
        jinja = "true";
        c = "65536";
        ctx-checkpoints = "1";
        no-warmup = "true";
        cache-ram = "0";
        parallel = "1";
        keep = "-1";
        temp = "1";
        top-p = "0.95";
        top-k = "64";
      };
    }
  );

  linuxModelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { } {
      "" = {
        version = "1";
      };
      "qwen3.6-35b-a3b" = {
        model = "/Users/rdb/models/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
        jinja = "true";
        c = "65536";
        ctx-checkpoints = "1";
        no-warmup = "true";
        cache-ram = "0";
        parallel = "1";
        keep = "-1";
        temp = "0.6";
        top-p = "0.95";
        top-k = "20";
        min-p = "0.00";
        presence-penalty = "0";
        repeat-penalty = "1";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
      };
    }
  );

in
{
  config = lib.mkIf (config.opt.features.llama-cpp.enable) {
    # Linux
    systemd.user.services.llama-cpp = lib.mkIf isLinux {
      Unit = {
        Description = "llama.cpp server (models.ini)";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${llama-server} --host 0.0.0.0 --port 11434 --config ${linuxModelsIni}";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "default.target" ];
    };

    # macOS
    launchd.agents.llama-cpp = lib.mkIf isDarwin {
      enable = true;
      config = {
        ProgramArguments = [
          "${llama-server}"
          "--host"
          "0.0.0.0"
          "--port"
          "11434"
          "--config"
          "${darwinModelsIni}"
        ];
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/llama-cpp.log";
        StandardErrorPath = "/tmp/llama-cpp.err.log";
      };
    };
  };
}
