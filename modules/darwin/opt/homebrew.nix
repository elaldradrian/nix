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
    ];
    brews = [
      "wasmcloud/wasmcloud/wash"
    ];
  };
}
