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
          }:
          let
            specialArgs = {
              inherit inputs self;
            }
            // {
              hostname = hostname;
              user = user;
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
        };
        rune-workstation = mkHost {
          hostname = "rune-workstation";
          user = "rune";
        };
        k3s-1 = mkHost {
          hostname = "k3s-1";
          user = "rune";
        };
        k3s-2 = mkHost {
          hostname = "k3s-2";
          user = "rune";
        };
        k3s-3 = mkHost {
          hostname = "k3s-3";
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
          }:
          let
            specialArgs = {
              inherit inputs self;
            }
            // {
              hostname = hostname;
              user = user;
              homeDir = "/Users/${user}";
            };
          in
          darwinSystem {
            inherit specialArgs;
            modules = default ++ [
              inputs.mac-app-util.darwinModules.default
              ./${hostname}
              (
                if user != null then
                  {
                    home-manager = {
                      useUserPackages = true;
                      users.${user}.imports = homeImports.${hostname};
                      extraSpecialArgs = specialArgs;
                      sharedModules = [
                        inputs.mac-app-util.homeManagerModules.default
                      ];
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
        };
      };
  };
}
