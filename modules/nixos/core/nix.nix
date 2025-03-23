{ user, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ user ];
    };
  };
}
