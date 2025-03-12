{ inputs, hostname, ... }:
{
  imports = [
    inputs.hm.nixosModules.home-manager
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

  opt = {
    features = {
      desktop.enable = false;
      k3s = {
        enable = true;
        clusterInit = false;
        serverAddr = "https://10.17.16.20:6443";
      };
      vpn.enable = false;
      docker.enable = false;
    };
    programs.steam.enable = false;
  };
}
