{
  pkgs,
  lib,
  config,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  hasNvidia = if isLinux then config.hardware.nvidia.modesetting.enable or false else false;

  llama-server =
    if isDarwin then
      "${pkgs.llama-cpp}/bin/llama-server"
    else if hasNvidia then
      "${pkgs.llama-cpp}/bin/llama-server"
    else
      "${pkgs.llama-cpp-vulkan}/bin/llama-server";

  configFile = pkgs.writeText "llama-swap-config.yaml" (
    builtins.toJSON {
      models = {
        "qwen3.5-9b" = {
          cmd = "${llama-server} --port \${PORT} -m /var/lib/llama-swap/models/Qwen3.5-9B-Q4_K_M.gguf --jinja -c 32768";
          ttl = 300;
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
        ExecStart = "${pkgs.llama-swap}/bin/llama-swap --config ${configFile} --listen localhost:11434";
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
          "localhost:11434"
        ];
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/llama-swap.log";
        StandardErrorPath = "/tmp/llama-swap.err.log";
      };
    };
  };
}
