{ self, ... }:
{
  imports = [
    "${self}/modules/home"
  ];

  opt = {
    features = {
      desktop.enable = false;
      devUtils.enable = true;
      docker.enable = true;
      games.enable = false;
      vpn.enable = false;
      work-machine.enable = true;
    };
    programs = {
      colima.enable = true;
      "1password".enable = true;
    };
  };
}
