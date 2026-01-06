{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    p7zip
    # XCode has to be installed from the App Store for darwin.xcode_* packages to work
    # Therefore it's installed as a sysytem dependency rather than a project flake to prevent nix gc
    darwin.xcode_16_4
  ];
}
