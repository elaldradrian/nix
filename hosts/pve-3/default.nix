{ inputs, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.hm.nixosModules.home-manager
  ];

  networking.hostName = hostname;

  core = {
    features = {
      proxmox = {
        enable = true;
        ipAddress = "10.17.16.3";
        bridges = [ "vmbr0" ];
        ceph = {
          enable = true;
          mgr.enable = false;
          mon.enable = true;
          mds = {
            enable = false;
            daemons = [ ];
          };
          osd = {
            enable = true;
            daemons = [
              "4"
              "6"
              "7"
            ];
          };
        };
      };
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
