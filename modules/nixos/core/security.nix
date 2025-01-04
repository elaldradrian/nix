{ config, lib, ... }:
{
  config = lib.mkIf config.core.programs.polkit.enable {
    security.polkit.enable = true;
  };
}
