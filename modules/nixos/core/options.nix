{ lib, ... }:
{
  options.core = with lib; {
    features = {
      proxmox.enable = mkEnableOption "Enable Proxmox";
      ssh.enable = mkEnableOption "Enable SSH";
      vm-guest.enable = mkEnableOption "Enable VM Guest";
    };
    programs.polkit.enable = mkEnableOption "Enable Polkit";
  };
}
