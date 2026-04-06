let
  default = [
    ./core/default.nix
    ./opt/default.nix
  ];
  proxmox = [
    ./core/proxmox.nix
  ];
in
{
  inherit default proxmox;
}
