{ lib, ... }:
{
  options.opt = with lib; {
    features = {
      desktop.enable = mkEnableOption "Enable desktop features";
      devUtils.enable = mkEnableOption "Enable development utilities";
      docker.enable = mkEnableOption "Enable Docker";
      ssh.work-profile.enable = mkEnableOption "Enable SSH work profile";
    };
    programs = {
      nvim.enable = mkEnableOption "Enable Neovim";
      colima.enable = mkEnableOption "Enable Colima";
      slack.enable = mkEnableOption "Enable Slack";
      dbeaver.enable = mkEnableOption "Enable DBeaver";
      "1password".enable = mkEnableOption "Enable 1Password";
    };
  };
}
