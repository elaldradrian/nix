{ inputs, ... }:
{
  imports = [
    inputs.hm.darwinModule
    ./hardware-configuration.nix
  ];
  networking.hostName = "k3s-1";
}
