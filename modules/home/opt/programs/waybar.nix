{ config, lib, ... }:
{
  config = lib.mkIf config.features.desktop.enable {
    programs.waybar.enable = true;
  };
}
