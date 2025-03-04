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
      ssh.work-profile.enable = false;
      work-machine.enable = false;
    };
    programs = {
      nvim.enable = true;
      colima.enable = false;
      slack.enable = false;
      dbeaver.enable = false;
      "1password".enable = false;
    };
  };
}
