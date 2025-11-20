{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
    settings = {
      indent.enable = true;
      highlight.enable = true;
    };
    folding = true;
  };
}
