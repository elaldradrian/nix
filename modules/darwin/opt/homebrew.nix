{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    # taps = [ "nikitabobko/tap" ];
    casks = [
      "brave-browser"
      "1Password"
      "scroll-reverser"
      "microsoft-teams"
      "microsoft-outlook"
      "microsoft-azure-storage-explorer"
      # "nikitabobko/tap/aerospace"
    ];
  };
}
