{ config, pkgs, ... }:
let
  commonPkgs = with pkgs; [
    git
    p7zip
    parted
    ceph-client
  ];

  vpnPkgs = with pkgs; [
    trayscale
  ];
in
{
  environment.systemPackages =
    commonPkgs ++ (if config.opt.features.vpn.enable then vpnPkgs else [ ]);
}
