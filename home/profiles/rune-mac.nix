{ self, ... }:
{
  imports = [
    "${self}/modules/home"
  ];

  home.homeDirectory = "/Users/rune";
}
