{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;

    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
    settings = {
      indent = {
        enable = true;
      };
      highlight = {
        enable = true;
      };
    };

    folding = true;
    nixvimInjections = true;
  };
}
