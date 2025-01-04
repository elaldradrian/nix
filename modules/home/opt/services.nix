{ config, lib, ... }:
{
  config = lib.mkIf config.opt.features.desktop.enable {
    services.gnome-keyring.enable = true;
  };
}
