{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.opt.features.desktop.enable {
    services = {
      greetd = {
        enable = true;
        settings.default_session.command = "${pkgs.greetd.tuigreet}/tuigreet --cmd sway";
      };
      gnome.gnome-keyring.enable = true;
    };
  };
}
