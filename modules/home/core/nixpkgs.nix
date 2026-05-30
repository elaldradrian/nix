{ inputs, user, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: _super: {
        stable = import inputs.nixpkgs-stable {
          inherit (self.stdenv.hostPlatform) system;
          config.allowUnfree = true;
        };
      })
      (final: prev: {
        x3270 = prev.x3270.overrideAttrs (old: {
          makeFlags = (old.makeFlags or [ ]) ++ [ "SOURCE_DATE_EPOCH=315532800" ];
        });
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
