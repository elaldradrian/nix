{ lib, ... }:
{
  options.core = with lib; {
    features = {
      vpn.enable = mkEnableOption "Enable VPN";
    };
  };
}
