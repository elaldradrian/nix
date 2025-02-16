{ lib, ... }:
{
  options.core = with lib; {
    features = {
      ssh.enable = mkEnableOption "Enable SSH";
      vm-guest.enable = mkEnableOption "Enable VM Guest";
      vpn.enable = mkEnableOption "Enable VPN";
    };
    programs.polkit.enable = mkEnableOption "Enable Polkit";
  };
}
