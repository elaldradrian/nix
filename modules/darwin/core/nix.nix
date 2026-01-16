{ user, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix = {
    optimise.automatic = true;
    linux-builder = {
      enable = true;
      package = pkgs.darwin.linux-builder-x86_64;
      ephemeral = true;
      systems = [
        "x86_64-linux"
        # "aarch64-linux"
      ];
      config = {
        # boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
        virtualisation = {
          darwin-builder = {
            diskSize = 50 * 1024;
            memorySize = 8 * 1024;
          };
          cores = 8;
        };
      };
    };
    distributedBuilds = true;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-platforms = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      builders-use-substitutes = true;
      # @admin is for linux-builder
      trusted-users = [
        user
        "@admin"
      ];
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      substituters = [
        "https://cache.iog.io"
      ];
    };
  };
}
