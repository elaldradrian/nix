{
  pkgs,
  ...
}:
{
  programs = {
    fish = {
      enable = true;
      plugins = [
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
      interactiveShellInit = "zoxide init fish | source";
    };
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
