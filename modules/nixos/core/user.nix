{ pkgs, ... }:
{
  users = {
    users.rune = {
      isNormalUser = true;
      description = "Rune Dahl Billeskov";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
    defaultUserShell = pkgs.fish;
  };
}
