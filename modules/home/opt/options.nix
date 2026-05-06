{ lib, ... }:
{
  options.opt = with lib; {
    features = {
      desktop.enable = mkEnableOption "Enable desktop features";
      llama-cpp.enable = mkEnableOption "Enable llama-cpp";
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
