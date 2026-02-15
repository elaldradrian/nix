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
      ssh.enable = true;
      vm-guest.enable = false;
    };
    programs.polkit.enable = true;
  };

  opt = {
    features = {
      desktop.enable = true;
      docker.enable = true;
      k3s.enable = false;
      vpn.enable = false;
    };
    programs.steam = {
      enable = true;
    };
  };
}
