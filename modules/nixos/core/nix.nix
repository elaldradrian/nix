{
  config,
  inputs,
  user,
  ...
}:
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
    optimise.automatic = true;
    settings = {
      extra-platforms = config.boot.binfmt.emulatedSystems;
      experimental-features = "nix-command flakes";
      trusted-users = [ user ];
    };
  };
}
