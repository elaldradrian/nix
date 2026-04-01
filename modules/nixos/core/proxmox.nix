{ config, lib, ... }:
{
  config = lib.mkIf config.core.features.proxmox.enable {
    services.proxmox-ve = {
      enable = true;
      ipAddress = "10.17.16.3";
      bridges = [ "vmbr0" ];
      ceph = {
        enable = true;
        mgr.enable = false;
        mon.enable = false;
        osd = {
          enable = false;
          daemons = [ ];
        };
      };
    };
  };
}
