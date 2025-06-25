{
  config,
  pkgs,
  homeDir,
  ...
}:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SOPS_AGE_KEY_FILE = "${homeDir}/.config/sops/age/keys.txt";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.nix-profile/bin"
    "/opt/homebrew/bin"
  ] ++ (if config.opt.features.work-machine.enable then [ "${pkgs.x3270}" ] else [ ]);
}
