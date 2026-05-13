{
  config,
  lib,
  ...
}:
{
  config = lib.mkMerge [
    {
      programs._1password.enable = true;
    }
    (lib.mkIf config.opt.features.desktop.enable {
      programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "rune" ];
      };
    })
  ];
}
