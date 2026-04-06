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

  llama-server = pkgs.llama-cpp.override {
    rpcSupport = true;
    cudaSupport = gpuBackend == "nvidia";
    cudaPackages = pkgs.cudaPackages_12_8;
    vulkanSupport = gpuBackend == "vulkan";
  };

  configFile = pkgs.writeText "llama-swap-config.yaml" (
    builtins.toJSON {
      models =
        if pkgs.stdenv.isDarwin then
          {
            "qwen3.5-35b-a3b" = {
              cmd = "${llama-server} --port \${PORT} --model /var/lib/llama-swap/models/Qwen3.5-35B-A3B-UD-IQ4_XS.gguf --jinja -c 65536 --no-warmup --parallel 1 --keep -1 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.00";
              ttl = 900;
            };
          }
        else
          {
            "qwen3.5-9b-s" = {
              cmd = "${llama-server} --port \${PORT} --model /var/lib/llama-swap/models/Qwen3.5-9B-UD-Q3_K_XL.gguf --jinja -c 32768 --no-warmup --parallel 1 --keep -1 --temp 0.5 --top-p 0.95 --top-k 20 --min-p 0.00 --presence-penalty 1.5 --repeat-penalty 1.0 --chat-template-kwargs '{\"enable_thinking\":false}'";
              ttl = 900;
            };
            "qwen3.5-9b-l" = {
              cmd = "${llama-server} --port \${PORT} --model /var/lib/llama-swap/models/Qwen3.5-9B-UD-Q4_K_XL.gguf --jinja -c 32768 --no-warmup --parallel 1 --keep -1 --temp 0.5 --top-p 0.95 --top-k 20 --min-p 0.00 --presence-penalty 1.5 --repeat-penalty 1.0 --chat-template-kwargs '{\"enable_thinking\":false}' -ctk q8_0 -ctv q8_0";
              ttl = 900;
            };
            "qwen3.5-35b-a3b-s" = {
              cmd = "${llama-server} --port \${PORT} --model /var/lib/llama-swap/models/Qwen3.5-35B-A3B-UD-IQ3_XXS.gguf --jinja -c 32768  --no-warmup --parallel 1 --keep -1 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.00";
              ttl = 900;
            };
            "qwen3.5-35b-a3b-l" = {
              cmd = "${llama-server} --port \${PORT} --model /var/lib/llama-swap/models/Qwen3.5-35B-A3B-UD-IQ4_XS.gguf --jinja -c 32768  --no-warmup --parallel 1 --keep -1 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.00";
              ttl = 900;
            };
            "qwen3.5-27b-s" = {
              cmd = "${llama-server} --port \${PORT} --model /var/lib/llama-swap/models/Qwen3.5-27B-UD-IQ2_XXS.gguf --jinja -c 32768  --no-warmup --parallel 1 --keep -1 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.00 --rpc rune-workstation.local.dahl-billeskov.com:50052";
              ttl = 900;
            };
            "qwen3.5-27b-l" = {
              cmd = "${llama-server} --port \${PORT} --model /var/lib/llama-swap/models/Qwen3.5-27B-UD-Q8_K_XL.gguf --jinja -c 32768  --no-warmup --parallel 1 --keep -1 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.00";
              ttl = 900;
            };
          };
    }
  );
in
{
  config = lib.mkIf (config.opt.features.llama-cpp.enable) {
    # Linux
    systemd.user.services.llama-swap = lib.mkIf isLinux {
      Unit = {
        Description = "llama-swap";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${pkgs.llama-swap}/bin/llama-swap --config ${configFile} --listen 0.0.0.0:11434";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "default.target" ];
    };

    # macOS
    launchd.agents.llama-swap = lib.mkIf isDarwin {
      enable = true;
      config = {
        ProgramArguments = [
          "${pkgs.llama-swap}/bin/llama-swap"
          "--config"
          "${configFile}"
          "--listen"
          "0.0.0.0:11434"
        ];
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/llama-swap.log";
        StandardErrorPath = "/tmp/llama-swap.err.log";
      };
    };
  };
}
