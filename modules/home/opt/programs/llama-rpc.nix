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

  llama-pkg = pkgs.llama-cpp.override {
    rpcSupport = true;
    cudaSupport = gpuBackend == "nvidia";
    cudaPackages = pkgs.cudaPackages_12_8;
    vulkanSupport = true;
  };

  llama-rpc-server = "${llama-pkg}/bin/llama-rpc-server";

  rpcPort = toString config.opt.features.llama-cpp.rpc-server.port;
in
{
  config = lib.mkIf config.opt.features.llama-cpp.rpc-server.enable {

    systemd.user.services.llama-rpc-server = lib.mkIf isLinux {
      Unit = {
        Description = "llama.cpp RPC server";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${llama-rpc-server} --host 0.0.0.0 --port ${rpcPort} -c";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "default.target" ];
    };

    launchd.agents.llama-rpc-server = lib.mkIf isDarwin {
      enable = true;
      config = {
        ProgramArguments = [
          "${llama-rpc-server}"
          "--host"
          "0.0.0.0"
          "--port"
          rpcPort
        ];
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/llama-rpc-server.log";
        StandardErrorPath = "/tmp/llama-rpc-server.err.log";
      };
    };
  };
}
