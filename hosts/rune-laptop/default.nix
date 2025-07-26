{
  inputs,
  hostname,
  ...
}:
{
  imports = [
    inputs.hm.nixosModules.home-manager
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
      docker.enable = true;
      k3s.enable = false;
      vpn.enable = true;
    };
    programs.steam = {
      enable = true;
    };
  };
}
