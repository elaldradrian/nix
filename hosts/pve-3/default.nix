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
      ssh.enable = true;
      vm-guest.enable = false;
    };
    programs.polkit.enable = false;
  };

  opt = {
    features = {
      desktop.enable = true;
      docker.enable = false;
      k3s.enable = false;
      vpn.enable = false;
    };
    programs.steam.enable = false;
  };
}
