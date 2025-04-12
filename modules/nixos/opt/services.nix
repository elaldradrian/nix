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
        settings.default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'sway --unsupported-gpu'";
          user = "greeter";
        };
      };
      gnome.gnome-keyring.enable = true;
    };
  };
}
