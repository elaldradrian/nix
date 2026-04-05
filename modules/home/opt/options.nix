{ lib, ... }:
{
  options.opt = with lib; {
    features = {
      desktop.enable = mkEnableOption "Enable desktop features";
      llama-cpp = {
        enable = mkEnableOption "Enable llama-cpp";
        rpc-server = {
          enable = lib.mkEnableOption "llama.cpp RPC server";
          port = lib.mkOption {
            type = lib.types.port;
            default = 50052;
            description = "Port for the llama-rpc-server to listen on";
          };
        };
      };
      devUtils.enable = mkEnableOption "Enable development utilities";
      docker.enable = mkEnableOption "Enable Docker";
      work-machine.enable = mkEnableOption "Enable work machine";
      vpn.enable = mkEnableOption "Enable VPN";
    };
    programs = {
      colima.enable = mkEnableOption "Enable Colima";
      "1password".enable = mkEnableOption "Enable 1Password";
    };
  };
}
