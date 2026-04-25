{ self, ... }:
{
  imports = [
    "${self}/modules/home"
  ];

  opt = {
    features = {
      desktop.enable = true;
      llama-cpp = {
        enable = true;
        rpc-server.enable = false;
      };
      devUtils.enable = true;
      docker.enable = false;
      vpn.enable = false;
      work-machine.enable = false;
    };
    programs = {
      colima.enable = false;
      "1password".enable = true;
    };
  };
}
