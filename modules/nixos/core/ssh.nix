{
  config,
  user,
  lib,
  ...
}:
{
  config = lib.mkIf config.core.features.ssh.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      authorizedKeysFiles = [
        "/etc/pve/priv/authorized_keys"
      ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "prohibit-password";
        AllowUsers = [
          "root"
          user
        ];
        UseDns = true;
        X11Forwarding = false;
        AcceptEnv = lib.mkForce [
          "LANG"
          "LC_*"
        ];
      };
    };
  };
}
