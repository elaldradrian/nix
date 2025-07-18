{ self, ... }:
{
  imports = [
    "${self}/modules/home"
  ];

  opt = {
    features = {
      desktop.enable = false;
      devUtils.enable = false;
      docker.enable = false;
      games.enable = false;
      vpn.enable = false;
      work-machine.enable = false;
    };
    programs = {
      colima.enable = false;
      "1password".enable = false;
    };
  };
}
