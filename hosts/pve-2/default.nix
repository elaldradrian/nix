{ inputs, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.hm.nixosModules.home-manager
  ];

  networking.hostName = hostname;

  nix.settings = {
    substituters = [ "http://10.17.16.2:5000" ];
    trusted-public-keys = [ "mycache:ME+pe82DGpgE+eR5IphLtSZ8/sCSap642K3c5ADkkfE=" ];
  };

  core = {
    features = {
      proxmox = {
        enable = true;
        ipAddress = "10.17.16.4";
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
              "2"
              "3"
              "5"
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
