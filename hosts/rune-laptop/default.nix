{
  inputs,
  ...
}:
{
  imports = [
    inputs.hm.nixosModule
    ./hardware-configuration.nix
  ];

  networking.hostName = "rune-laptop";

  core.programs.polkit.enable = true;

  opt.features.desktop.enable = true;
}
