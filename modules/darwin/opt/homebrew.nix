{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "1Password"
      "sol"
      "scroll-reverser"
      "microsoft-teams"
      "microsoft-outlook"
      "microsoft-azure-storage-explorer"
      "homerow"
      "google-chrome"
      "slack"
      "notunes"
      "android-studio"
    ];
  };
}
