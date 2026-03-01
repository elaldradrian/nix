{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "1Password"
      "scroll-reverser"
      "microsoft-teams"
      "microsoft-outlook"
      "microsoft-azure-storage-explorer"
      "homerow"
      "google-chrome"
      "tailscale-app"
      "slack"
      "notunes"
      "android-studio"
    ];
    brews = [
      "wasmcloud/wasmcloud/wash"
    ];
  };
}
