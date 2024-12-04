{
  nix = {
    useDaemon = true;
    settings = {
      experimental-features = "nix-command flakes";
    };
  };
}
