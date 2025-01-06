{ config, lib, ... }:
{
  config = lib.mkIf config.core.features.vm-guest.enable {
    services.qemuGuest.enable = true;
  };
}
