{
  self,
  inputs,
  ...
}:
{
  flake = {
    nixosConfigurations =
      let
        inherit (inputs.nixpkgs.lib) nixosSystem;
        inherit (import "${self}/modules/nixos") default;

        homeImports = import "${self}/home";

        mkHost =
          {
            hostname,
            user ? null,
            gpuBackend,
          }:
          let
            specialArgs = {
              inherit inputs self;
            }
            // {
              hostname = hostname;
              user = user;
              gpuBackend = gpuBackend;
              homeDir = "/home/${user}";
            };
          in
          nixosSystem {
            inherit specialArgs;
            modules = default ++ [
              ./${hostname}
              (
                if user != null then
                  {
                    home-manager = {
                      users.${user}.imports = homeImports.${hostname};
                      extraSpecialArgs = specialArgs;
                    };
                  }
                else
                  { }
              )
            ];
          };
      in
      {
        rune-laptop = mkHost {
          hostname = "rune-laptop";
          user = "rune";
          gpuBackend = "vulkan";
        };
        rune-workstation = mkHost {
          hostname = "rune-workstation";
          user = "rune";
          gpuBackend = "nvidia";
        };
        k3s-1 = mkHost {
          hostname = "k3s-1";
          user = "rune";
          gpuBackend = "vulkan";
        };
        k3s-2 = mkHost {
          hostname = "k3s-2";
          user = "rune";
          gpuBackend = "vulkan";
        };
        k3s-3 = mkHost {
          hostname = "k3s-3";
          user = "rune";
          gpuBackend = "vulkan";
        };
        pve-3 = mkHost {
          hostname = "pve-3";
          user = "rune";
        };
      };

    darwinConfigurations =
      let
        inherit (inputs.nix-darwin.lib) darwinSystem;
        inherit (import "${self}/modules/darwin") default;

        homeImports = import "${self}/home";

        mkHost =
          {
            hostname,
            user ? null,
            gpuBackend,
          }:
          let
            specialArgs = {
              inherit inputs self;
            }
            // {
              hostname = hostname;
              user = user;
              homeDir = "/Users/${user}";
              gpuBackend = gpuBackend;
            };
          in
          darwinSystem {
            inherit specialArgs;
            modules = default ++ [
              ./${hostname}
              (
                if user != null then
                  {
                    home-manager = {
                      useUserPackages = true;
                      users.${user}.imports = homeImports.${hostname};
                      extraSpecialArgs = specialArgs;
                    };
                  }
                else
                  { }
              )
            ];
          };
      in
      {
        rune-mac = mkHost {
          hostname = "rune-mac";
          user = "rdb";
          gpuBackend = "metal";
        };
      };
  };
}
