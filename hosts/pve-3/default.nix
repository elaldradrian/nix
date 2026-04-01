{ inputs, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.proxmox-nixos.nixosModules.proxmox-ve
    inputs.hm.nixosModules.home-manager
  ];

  networking.hostName = hostname;

  core = {
    features = {
      proxmox.enable = true;
      ssh.enable = true;
      vm-guest.enable = false;
    };
    programs.polkit.enable = false;
  };

  opt = {
    features = {
      ceph.enable = false;
      desktop.enable = false;
      docker.enable = false;
      k3s.enable = false;
      vpn.enable = false;
    };
    programs.steam.enable = false;
  };
}
