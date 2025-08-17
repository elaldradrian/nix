{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    p7zip
    parted
    stable.ceph-client
  ];
}
