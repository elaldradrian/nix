{
  services.nix-daemon.enable = true;
  services = {
    aerospace = {
      enable = true;
      settings = {
        after-login-command = [ ];
        after-startup-command = [ ];
        enable-normalization-flatten-containers = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;
        accordion-padding = 30;
        default-root-container-layout = "tiles";
        default-root-container-orientation = "auto";
        on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
        automatically-unhide-macos-hidden-apps = false;

        key-mapping = {
          preset = "qwerty";
        };

        gaps = {
          inner.horizontal = 0;
          inner.vertical = 0;
          outer.left = 0;
          outer.bottom = 0;
          outer.top = 0;
          outer.right = 0;
        };

        mode.main.binding = {
          cmd-slash = "layout tiles horizontal vertical";
          cmd-comma = "layout accordion horizontal vertical";

          cmd-left = "focus left";
          cmd-down = "focus down";
          cmd-up = "focus up";
          cmd-right = "focus right";

          cmd-shift-left = "move left";
          cmd-shift-down = "move down";
          cmd-shift-up = "move up";
          cmd-shift-right = "move right";

          cmd-shift-minus = "resize smart -50";
          cmd-shift-equal = "resize smart +50";

          cmd-1 = "workspace 1";
          cmd-2 = "workspace 2";
          cmd-3 = "workspace 3";
          cmd-4 = "workspace 4";
          cmd-5 = "workspace 5";
          cmd-6 = "workspace 6";
          cmd-7 = "workspace 7";
          cmd-8 = "workspace 8";
          cmd-9 = "workspace 9";

          cmd-shift-1 = "move-node-to-workspace 1";
          cmd-shift-2 = "move-node-to-workspace 2";
          cmd-shift-3 = "move-node-to-workspace 3";
          cmd-shift-4 = "move-node-to-workspace 4";
          cmd-shift-5 = "move-node-to-workspace 5";
          cmd-shift-6 = "move-node-to-workspace 6";
          cmd-shift-7 = "move-node-to-workspace 7";
          cmd-shift-8 = "move-node-to-workspace 8";
          cmd-shift-9 = "move-node-to-workspace 9";

          cmd-shift-semicolon = "mode service";
        };

        mode.service.binding = {
          esc = [
            "reload-config"
            "mode main"
          ];
          r = [
            "flatten-workspace-tree"
            "mode main"
          ];
          f = [
            "layout floating tiling"
            "mode main"
          ];
          backspace = [
            "close-all-windows-but-current"
            "mode main"
          ];
        };
      };
    };
  };
}
