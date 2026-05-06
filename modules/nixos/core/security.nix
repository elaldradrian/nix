{
  config,
  user,
  lib,
  ...
}:
{
  config = lib.mkMerge [
    {
      security.pam.loginLimits = [
        {
          domain = user;
          type = "-";
          item = "memlock";
          value = "unlimited";
        }
      ];
    }
    (lib.mkIf config.core.programs.polkit.enable {
      security.polkit.enable = true;
    })
  ];
}
