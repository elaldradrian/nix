{ pkgs, ... }:
{
  users = {
    users.rune = {
      isNormalUser = true;
      description = "Rune Dahl Billeskov";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGfqJV+LLTDqhZboTExbEZChKbIdQwhNJXSmKEYfdOJ"
      ];
    };
    defaultUserShell = pkgs.fish;
  };
}
