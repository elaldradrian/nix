{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations =
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
          } // { hostname = hostname; };
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
      k3s-1 = mkHost {
        hostname = "k3s-1";
        user = "rune";
      };
    };

  flake.darwinConfigurations =
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
          } // { hostname = hostname; };
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
        user = "rune";
      };
    };
}
