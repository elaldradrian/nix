{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "brave-browser"
      "google-chrome"
      "1Password"
      "scroll-reverser"
      "microsoft-teams"
      "microsoft-outlook"
      "microsoft-azure-storage-explorer"
    ];
  };
}
