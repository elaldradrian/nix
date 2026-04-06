{
  inputs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.core.features.proxmox.enable {

    nixpkgs.overlays = [
      inputs.proxmox-nixos.overlays.x86_64-linux
    ];

    services.proxmox-ve = {
      enable = true;
      ipAddress = "10.17.16.3";
      bridges = [ "vmbr0" ];
      ceph = {
        enable = true;
        mgr.enable = false;
        mon.enable = false;
        mds.enable = false;
        osd = {
          enable = true;
          daemons = [ "4" ];
        };
      };
    };
  };
}
