{
  description = "Runes flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    hm.url = "github:nix-community/home-manager";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";

    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcp-hub.inputs.nixpkgs.follows = "nixpkgs";

    mcp-hub-nvim.url = "github:ravitemer/mcphub.nvim";
    mcp-hub-nvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      imports = [
        ./hosts
        ./pre-commit-hooks.nix
        ./packages/nvim/flake-module.nix
      ];

      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              (self: _super: {
                stable = import inputs.nixpkgs-stable {
                  inherit (self) system;
                  config.allowUnfree = true;
                };
              })
            ];
            config.allowUnfree = true;
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nixfmt-rfc-style
              git
            ];
            name = "dots";
            DIRENV_LOG_FORMAT = "";
            shellHook = # Bash
              ''
                ${config.pre-commit.installationScript}
              '';
          };

          formatter = pkgs.nixfmt-rfc-style;
        };
      debug = true;
    };
}
