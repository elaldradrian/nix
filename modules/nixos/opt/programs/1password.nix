{ config, lib, ... }:
{
  config = lib.mkIf config.opt.features.desktop.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "rune" ];
    };
  };
}
