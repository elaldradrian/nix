{ config, lib, ... }:
{
  config = lib.mkIf config.core.features.ssh.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        AcceptEnv = lib.mkForce [
          "LANG"
          "LC_*"
        ];
        PasswordAuthentication = true;
        AllowUsers = [ "rune" ];
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "no";
      };
    };
  };
}
