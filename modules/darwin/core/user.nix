{ pkgs, ... }:
{
  users.users."rune" = {
    uid = 501;
    shell = pkgs.fish;
    home = "/Users/rune";
  };
}
