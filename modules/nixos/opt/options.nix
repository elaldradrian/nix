{ lib, ... }:
{
  options.opt = {
    features = {
      desktop.enable = lib.mkEnableOption "Enable desktop features";
    };
  };
}
