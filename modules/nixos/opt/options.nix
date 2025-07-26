{ lib, ... }:
{
  options.opt = with lib; {
    features = {
      desktop.enable = mkEnableOption "Enable desktop";
      docker.enable = mkEnableOption "Enable docker";
      k3s = {
        enable = mkEnableOption "Enable k3s";
        clusterInit = mkEnableOption "Initialize k3s cluster";
        serverAddr = mkOption {
          type = types.str;
          default = "";
        };
      };
      vpn.enable = mkEnableOption "Enable VPN";
    };
    programs = {
      steam = {
        enable = mkEnableOption "Enable Steam";
      };
    };
  };
}
