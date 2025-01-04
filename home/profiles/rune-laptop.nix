{ self, ... }:
{
  imports = [
    "${self}/modules/home"
  ];

  home.homeDirectory = "/home/rune";

  features = {
    desktop.enable = true;
    devUtils.enable = true;
    docker.enable = false;
  };
  programs = {
    nvim.enable = true;
    colima.enable = false;
    slack.enable = false;
    dbeaver.enable = false;
    "1password".enable = true;
  };
}
