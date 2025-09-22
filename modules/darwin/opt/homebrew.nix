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
      "tailscale"
      "slack"
    ];
    brews = [
      "wasmcloud/wasmcloud/wash"
    ];
  };
}
