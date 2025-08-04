{ inputs, ... }:
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
}
