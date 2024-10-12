{
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
  };

  imports = [
    ./icons.nix
    # ./bracketed.nix
    ./clue.nix
    ./hipatterns.nix
    ./indent-scope.nix
    ./surround.nix
  ];
}
