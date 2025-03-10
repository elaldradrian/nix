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
      ssh.work-profile.enable = false;
      work-machine.enable = false;
    };
    programs = {
      nvim.enable = true;
      colima.enable = false;
      slack.enable = false;
      dbeaver.enable = false;
      "1password".enable = true;
    };
  };
}
