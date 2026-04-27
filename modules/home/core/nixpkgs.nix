{ inputs, user, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: _super: {
        stable = import inputs.nixpkgs-stable {
          inherit (self) system;
          config.allowUnfree = true;
        };
      })
    ];
  };
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ user ];
    };
  };
}
