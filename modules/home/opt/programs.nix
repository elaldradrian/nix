{
  self,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs = {
    fish = {
      enable = true;
      plugins = [
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
    };
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
    nixvim = import "${self}/packages/nvim" // {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
