{ config, pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      git
      p7zip
    ]
    ++ (if config.opt.programs.steam.enable then [ pkgs.steam ] else [ ]);
}
