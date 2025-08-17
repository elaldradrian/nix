{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.opt.features.vpn.enable {
    services.tailscale.enable = true;
    services.tailscale.useRoutingFeatures = "client";
    environment.systemPackages = with pkgs; [
      tailscale
      trayscale
    ];
  };
}
