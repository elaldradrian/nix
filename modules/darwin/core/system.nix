{ self, ... }:
{
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
}
