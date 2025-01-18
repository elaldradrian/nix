{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    hlint
  ];

  plugins.lint = {
    enable = true;
    lintersByFt = {
      haskell = [ "hlint" ];
    };
  };
}
