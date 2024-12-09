{
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
  };

  imports = [
    ./bracketed.nix
    # ./clue.nix
    ./diff.nix
    ./hipatterns.nix
    ./icons.nix
    ./move.nix
    ./surround.nix
    ./trailspace.nix
  ];
}
