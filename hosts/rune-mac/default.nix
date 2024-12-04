{ inputs, ... }:
{
  imports = [
    inputs.hm.darwinModule
    ./hardware-configuration.nix
  ];
  networking.hostName = "rune-mac";
}
