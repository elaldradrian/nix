{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    p7zip
  ];
}
