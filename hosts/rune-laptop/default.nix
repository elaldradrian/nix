{
  inputs,
  hostname,
  ...
}:
{
  imports = [
    inputs.hm.nixosModule
    ./hardware-configuration.nix
  ];

  networking.hostName = hostname;

  core = {
    features = {
      ssh.enable = false;
      vm-guest.enable = false;
    };
    programs.polkit.enable = true;
  };

  opt = {
    features = {
      desktop.enable = true;
      k3s.enable = false;
    };
    programs.steam.enable = true;
  };
}
