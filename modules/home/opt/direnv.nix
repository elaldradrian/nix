{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
    config = {
      load_dotenv = true;
    };
  };
}
