{ self, ... }:
{
  imports = [
    "${self}/modules/home"
  ];

  opt = {
    features = {
      desktop.enable = true;
      devUtils.enable = true;
      docker.enable = false;
      work-machine.enable = false;
      games.enable = true;
    };
    programs = {
      colima.enable = false;
      "1password".enable = true;
    };
  };
}
