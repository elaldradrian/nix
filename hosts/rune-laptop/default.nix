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
}
