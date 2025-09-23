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
      mcp-hub = inputs.mcp-hub.packages."${system}".default;
      mcp-hub-nvim = inputs.mcp-hub-nvim.packages."${system}".default;
    in
    {
      # Run using `nix run .#nvim`
      packages.nvim = makeNixvimWithModule {
        inherit pkgs;
        module = self.nixvimModules.default;
        extraSpecialArgs = {
          inherit self inputs;
          inherit mcp-hub-nvim;
          inherit mcp-hub;
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
