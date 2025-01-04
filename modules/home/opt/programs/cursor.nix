{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.opt.features.desktop.enable {
    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 42;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };
  };
}
