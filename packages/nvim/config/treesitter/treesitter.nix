{ pkgs, ... }:
{
  extraPackages = [ pkgs.tree-sitter ];
  plugins.treesitter = {
    enable = true;
    indent.enable = true;
    highlight.enable = true;
    folding.enable = true;
  };
}
