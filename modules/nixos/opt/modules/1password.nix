{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    {
      programs._1password.enable = true;
      environment.systemPackages = with pkgs; [
        _1password-cli
      ];
    }
    (lib.mkIf config.opt.features.desktop.enable {
      programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "rune" ];
      };
    })
  ];
}
