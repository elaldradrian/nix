{ config, lib, ... }:
{
  config = lib.mkIf config.core.polkit.enable {
    security.polkit.enable = true;
  };
}
