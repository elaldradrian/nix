{ config, pkgs, ... }:
let
  aerospaceExe = "${config.services.aerospace.package}/bin/aerospace";
  # I3/SwayWM behavior
  switchWorkspace = pkgs.writeShellScript "aerospace-switch-workspace" ''
    ws="$1"
    windows=$(${aerospaceExe} list-windows --workspace "$ws" 2>/dev/null)
    visible=$(${aerospaceExe} list-workspaces --monitor all --visible 2>/dev/null | grep -x "$ws")

    if [ -n "$windows" ] || [ -n "$visible" ];  then
      ${aerospaceExe} workspace "$ws"
    else
      ${aerospaceExe} summon-workspace "$ws"
    fi
  '';
  moveToWorkspace = pkgs.writeShellScript "aerospace-move-to-workspace" ''
    ws="$1"
    ${aerospaceExe} move-node-to-workspace "$ws"
  '';
in
{
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
        on-focused-monitor-changed = [ ];
        automatically-unhide-macos-hidden-apps = true;

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

          cmd-1 = "exec-and-forget ${switchWorkspace} 1";
          cmd-2 = "exec-and-forget ${switchWorkspace} 2";
          cmd-3 = "exec-and-forget ${switchWorkspace} 3";
          cmd-4 = "exec-and-forget ${switchWorkspace} 4";
          cmd-5 = "exec-and-forget ${switchWorkspace} 5";
          cmd-6 = "exec-and-forget ${switchWorkspace} 6";
          cmd-7 = "exec-and-forget ${switchWorkspace} 7";
          cmd-8 = "exec-and-forget ${switchWorkspace} 8";
          cmd-9 = "exec-and-forget ${switchWorkspace} 9";

          cmd-shift-1 = "exec-and-forget ${moveToWorkspace} 1";
          cmd-shift-2 = "exec-and-forget ${moveToWorkspace} 2";
          cmd-shift-3 = "exec-and-forget ${moveToWorkspace} 3";
          cmd-shift-4 = "exec-and-forget ${moveToWorkspace} 4";
          cmd-shift-5 = "exec-and-forget ${moveToWorkspace} 5";
          cmd-shift-6 = "exec-and-forget ${moveToWorkspace} 6";
          cmd-shift-7 = "exec-and-forget ${moveToWorkspace} 7";
          cmd-shift-8 = "exec-and-forget ${moveToWorkspace} 8";
          cmd-shift-9 = "exec-and-forget ${moveToWorkspace} 9";

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
