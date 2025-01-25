{ lib, ... }:
{
  options.opt = with lib; {
    features = {
      desktop.enable = mkEnableOption "Enable desktop features";
      k3s = {
        enable = mkEnableOption "Enable k3s";
        clusterInit = mkEnableOption "Initialize k3s cluster";
        serverAddr = mkOption {
          type = types.str;
          default = "";
        };
      };
    };
    programs = {
      steam = {
        enable = mkEnableOption "Enable Steam";
      };
    };
  };
}
