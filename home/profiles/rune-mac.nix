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
      work-machine.enable = true;
      games.enable = false;
    };
    programs = {
      colima.enable = true;
      "1password".enable = true;
    };
  };
}
