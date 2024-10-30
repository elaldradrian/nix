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

          environment.systemPackages = with pkgs; [
            wezterm
            git
            gh
            slack
            fish
            # fishPlugins.fzf-fish
            fishPlugins.z
            p7zip
            postman
            docker
            colima
            node2nix
            # aerospace
          ];

          services.nix-daemon.enable = true;

          nix = {
            useDaemon = true;
            settings = {
              experimental-features = "nix-command flakes";
            };
          };

          imports = [
            nixvim.nixDarwinModules.nixvim
          ];

          programs = {
            fish.enable = true;
            direnv.enable = true;
            nixvim = import ./nvim // {
              enable = true;
              viAlias = true;
              vimAlias = true;
            };
          };

          homebrew = {
            enable = true;
            onActivation.cleanup = "uninstall";
            taps = [ "nikitabobko/tap" ];
            casks = [
              "brave-browser"
              "1Password"
              "scroll-reverser"
              "microsoft-teams"
              "microsoft-outlook"
              "nikitabobko/tap/aerospace"
              "microsoft-azure-storage-explorer"
            ];
          };

          fonts.packages = [ pkgs.fira-code ];

          security.pam.enableSudoTouchIdAuth = true;

          users = {
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
            };
            defaults = {
              dock.autohide = true;
              dock.mru-spaces = false;
              dock.show-recents = false;
              finder.AppleShowAllExtensions = true;
              finder.FXPreferredViewStyle = "clmv";
              NSGlobalDomain.AppleInterfaceStyle = "Dark";
              ".GlobalPreferences"."com.apple.mouse.scaling" = 1.0;
              NSGlobalDomain.NSScrollAnimationEnabled = false;
              screensaver.askForPasswordDelay = 10;
              loginwindow.PowerOffDisabledWhileLoggedIn = true;
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
