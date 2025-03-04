{ pkgs, user, ... }:
{
  users.users."${user}" = {
    uid = 501;
    shell = pkgs.fish;
    home = "/Users/${user}";
  };
}
