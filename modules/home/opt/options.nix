{ lib, ... }:
{
  options.opt = with lib; {
    features = {
      desktop.enable = mkEnableOption "Enable desktop features";
      devUtils.enable = mkEnableOption "Enable development utilities";
      docker.enable = mkEnableOption "Enable Docker";
      work-machine.enable = mkEnableOption "Enable work machine";
      games.enable = mkEnableOption "Enable games";
    };
    programs = {
      colima.enable = mkEnableOption "Enable Colima";
      "1password".enable = mkEnableOption "Enable 1Password";
    };
  };
}
