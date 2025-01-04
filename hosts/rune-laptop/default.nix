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

  core = {
    features = {
      ssh.enable = false;
      vm-guest.enable = false;
    };
    programs.polkit.enable = true;
  };

  opt.features.desktop.enable = true;
}
