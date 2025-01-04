{ pkgs, ... }:
{
  fonts.packages = [
    pkgs.fira-code
    pkgs.nerd-fonts.fira-code
  ];
}
