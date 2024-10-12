{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = inputs@{ self,nixpkgs, nix-darwin,nixvim  }:
  let
    configuration = { pkgs,  ... }: {
      nixpkgs.config.allowUnfree = true;

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

  programs.nixvim = (import ./nvim { pkgs = pkgs; }) // {
    enable = true;
    viAlias = true;
    vimAlias = true;
    };

      programs.fish.enable = true;

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

      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.stateVersion = 5;

      nixpkgs.hostPlatform = "aarch64-darwin";

      security.pam.enableSudoTouchIdAuth = true;
      users.knownUsers = [ "rune" ];
      users.users."rune" = {
        uid = 501;
        shell = pkgs.fish;
      };      

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
	dock.show-recents = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        screensaver.askForPasswordDelay = 10;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
	".GlobalPreferences"."com.apple.mouse.scaling" = .1;
	NSGlobalDomain.NSScrollAnimationEnabled = false;
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
