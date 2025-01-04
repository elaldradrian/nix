{ inputs, ... }:
{
  imports = [
    inputs.hm.darwinModule
    ./hardware-configuration.nix
  ];

  networking.hostName = "k3s-1";

  core.programs.polkit.enable = true;

  opt.features.desktop.enable = true;
}
