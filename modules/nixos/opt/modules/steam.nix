{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.opt.programs.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;
    environment.systemPackages = with pkgs; [
      protonup
      mangohud
    ];
  };
}
