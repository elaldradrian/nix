{
  self,
  inputs,
  ...
}:
{
  flake = {
    nixvimModules.default = import ./config;
  };

  perSystem =
    {
      self',
      pkgs,
      system,
      ...
    }:
    let
      inherit (inputs.nixvim.legacyPackages.${system}) makeNixvimWithModule;
      inherit (inputs.nixvim.lib.${system}.check) mkTestDerivationFromNvim;

      # Temporary: nixpkgs master ships a stale FOD hash for kulala-core's
      # bun-built node_modules. Pin to the hash our build actually produces.
      # Drop this once upstream re-pins (check `nix flake update nixpkgs` first).
      kulalaOverlay = final: prev: {
        kulala-core = prev.kulala-core.overrideAttrs (old: {
          node_modules = old.node_modules.overrideAttrs (_: {
            outputHash = "sha256-XQlBawD3vt8pVc7Gy9XeiGie89HWbljNJt7kUEDaDKk=";
          });
        });
      };

      patchedPkgs = pkgs.extend kulalaOverlay;
    in
    {
      # Run using `nix run .#nvim`
      packages.nvim = makeNixvimWithModule {
        pkgs = patchedPkgs;
        module = self.nixvimModules.default;
        extraSpecialArgs = {
          inherit self inputs;
        };
      };

      # `nix flake check` will also validate config
      checks.nvim = mkTestDerivationFromNvim {
        inherit (self'.packages) nvim;
        name = "Custom Neovim";
      };
      debug = true;
    };
}
