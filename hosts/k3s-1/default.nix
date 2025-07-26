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
      docker.enable = false;
      k3s = {
        enable = true;
        clusterInit = true;
        serverAddr = "";
      };
      vpn.enable = false;
    };
    programs.steam.enable = false;
  };
}
