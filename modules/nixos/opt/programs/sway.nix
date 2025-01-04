{ config, lib, ... }:
{
  config = lib.mkIf config.opt.features.desktop.enable {
    programs.sway.enable = true;
  };
}
