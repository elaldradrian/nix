{ inputs, hostname, ... }:
{
  imports = [
    inputs.hm.nixosModule
    ./hardware-configuration.nix
  ];

  networking.hostName = hostname;

  core = {
    features = {
      ssh.enable = true;
      vm-guest.enable = true;
    };
    programs.polkit.enable = false;
  };

  opt.features = {
    desktop.enable = false;
    k3s = {
      enable = true;
      clusterInit = true;
      serverAddr = "";
    };
  };
}
