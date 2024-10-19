{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixvim,
      ...
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          nixpkgs = {
            config.allowUnfree = true;
            hostPlatform = "aarch64-darwin";
          };

          environment.systemPackages = [
            pkgs.wezterm
            pkgs.git
            pkgs.gh
            pkgs.slack
            pkgs.fish
            pkgs.p7zip
          ];

          services.nix-daemon.enable = true;

          nix.settings.experimental-features = "nix-command flakes";

          imports = [
            nixvim.nixDarwinModules.nixvim
          ];

          programs = {
            fish.enable = true;
            nixvim = import ./nvim // {
              enable = true;
              viAlias = true;
              vimAlias = true;
            };
          };

          homebrew = {
            enable = true;
            onActivation.cleanup = "uninstall";
            casks = [
              "brave-browser"
              "1Password"
              "scroll-reverser"
              "microsoft-teams"
              "microsoft-outlook"
            ];
          };

          fonts.packages = [ pkgs.fira-code ];

          security.pam.enableSudoTouchIdAuth = true;
          users = {
            knownUsers = [ "rune" ];
            users."rune" = {
              uid = 501;
              shell = pkgs.fish;
            };
          };

          system = {
            stateVersion = 5;
            configurationRevision = self.rev or self.dirtyRev or null;
            keyboard = {
              enableKeyMapping = true;
              remapCapsLockToEscape = true;
              remapCapsLockToControl = true;
            };
            defaults = {
              dock.autohide = true;
              dock.mru-spaces = false;
              dock.show-recents = false;
              finder.AppleShowAllExtensions = true;
              finder.FXPreferredViewStyle = "clmv";
              screensaver.askForPasswordDelay = 10;
              NSGlobalDomain.AppleInterfaceStyle = "Dark";
              ".GlobalPreferences"."com.apple.mouse.scaling" = 0.1;
              NSGlobalDomain.NSScrollAnimationEnabled = false;
            };
          };
        };
    in
    {
      darwinConfigurations."rune-mac" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };

      packages.aarch64-darwin.nvim = nixvim.legacyPackages."aarch64-darwin".makeNixvimWithModule {
        module = ./nvim;
      };
    };
}
