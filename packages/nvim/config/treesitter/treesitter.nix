{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    lazyLoad.settings.event = "BufReadPost";
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
    settings = {
      indent.enable = true;
      highlight.enable = true;
    };
    folding = true;
  };
}
