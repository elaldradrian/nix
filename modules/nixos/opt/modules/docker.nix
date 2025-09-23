{ config, lib, ... }:
{
  config = lib.mkIf config.opt.features.docker.enable {
    virtualisation.docker = {
      enable = true;
      enableNvidia = true;
    };
  };
}
