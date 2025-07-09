{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.opt.features.vpn.enable {
    services.trayscale.enable = true;
  };
}
