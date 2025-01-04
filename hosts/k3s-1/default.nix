{ inputs, ... }:
{
  imports = [
    inputs.hm.darwinModule
    ./hardware-configuration.nix
  ];

  networking.hostName = "k3s-1";

  core = {
    features = {
      ssh.enable = true;
      vm-guest.enable = true;
    };
    programs.polkit.enable = false;
  };

  opt.features.desktop.enable = false;
}
