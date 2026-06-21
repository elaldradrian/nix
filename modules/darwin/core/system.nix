{ self, user, ... }:
{
  system = {
    primaryUser = user;
    stateVersion = 6;
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
      ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;
      NSGlobalDomain.NSScrollAnimationEnabled = false;
      screensaver.askForPasswordDelay = 10;
      loginwindow.PowerOffDisabledWhileLoggedIn = true;
      CustomUserPreferences."com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
        "64" = { enabled = false; };  # ⌘Space  Spotlight search
        "65" = { enabled = false; };  # ⌥⌘Space Finder search window
      };
    };
    activationScripts.postActivation.text = ''
      if /usr/bin/mdutil -s / | grep -q "Indexing enabled"; then
        /usr/bin/mdutil -i off -a || true
      fi
    '';
  };
}
