{ inputs, hostname, ... }:
{
  imports = [
    inputs.hm.darwinModule
    ./hardware-configuration.nix
  ];
  networking.hostName = hostname;
}
