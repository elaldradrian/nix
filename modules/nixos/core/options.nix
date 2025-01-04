{ lib, ... }:
{
  options.core.programs.polkit.enable = lib.mkEnableOption "Enable Polkit";
}
