{
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.core.features.proxmox;
in
{
  config = lib.mkIf cfg.enable {

    nixpkgs.overlays = [
      inputs.proxmox-nixos.overlays.aarch64-linux
    ];

    services.proxmox-ve = {
      enable = true;
      ipAddress = cfg.ipAddress;
      bridges = cfg.bridges;
      ceph = {
        enable = cfg.ceph.enable;
        mgr.enable = cfg.ceph.mgr.enable;
        mon.enable = cfg.ceph.mon.enable;
        mds = {
          enable = cfg.ceph.mds.enable;
          daemons = cfg.ceph.mds.daemons;
        };
        osd = {
          enable = cfg.ceph.osd.enable;
          daemons = cfg.ceph.osd.daemons;
        };
      };
    };
  };
}
