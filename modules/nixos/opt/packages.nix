{ config, pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      git
      p7zip
      parted
    ]
    ++ (if config.core.features.proxmox.enable then [ pkgs.ceph ] else [ ]);
}
