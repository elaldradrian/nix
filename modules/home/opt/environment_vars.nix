{ config, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
