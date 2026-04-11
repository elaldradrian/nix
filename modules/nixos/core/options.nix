{ lib, ... }:
{
  options.core = with lib; {
    features = {
      proxmox = {
        enable = mkEnableOption "Enable Proxmox";
        ipAddress = mkOption {
          type = types.str;
          default = "";
          description = "IP address of the Proxmox node";
        };
        bridges = mkOption {
          type = types.listOf types.str;
          default = [ ];
          description = "Network bridges for Proxmox";
        };
        ceph = {
          enable = mkEnableOption "Enable Proxmox Ceph";
          mgr.enable = mkEnableOption "Enable Ceph Manager";
          mon.enable = mkEnableOption "Enable Ceph Monitor";
          mds = {
            enable = mkEnableOption "Enable Ceph MDS";
            daemons = mkOption {
              type = types.listOf types.str;
              default = [ ];
              description = "List of MDS daemon names";
            };
          };
          osd = {
            enable = mkEnableOption "Enable Ceph OSD";
            daemons = mkOption {
              type = types.listOf types.str;
              default = [ ];
              description = "List of OSD daemon IDs";
            };
          };
        };
      };
      ssh.enable = mkEnableOption "Enable SSH";
      vm-guest.enable = mkEnableOption "Enable VM Guest";
    };
    programs.polkit.enable = mkEnableOption "Enable Polkit";
  };
}
