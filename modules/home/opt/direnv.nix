{ inputs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
    config = {
      load_dotenv = true;
    };
  };

  imports = [
    inputs.direnv-instant.homeModules.direnv-instant
  ];

  programs.direnv-instant.enable = true;
}
