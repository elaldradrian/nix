{ config, lib, ... }:
{
  config = lib.mkIf config.opt.features.desktop.enable {
    hardware.acpilight.enable = true;
  };
}
