{
  lib,
  config,
  pkgs,
  ...
}:
let
  mod = "Mod4";
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = mod;
      terminal = lib.getExe pkgs.wezterm;
      defaultWorkspace = "workspace number 1";

      focus.followMouse = "no";

      startup = [
        { command = "1password --silent"; }
      ];

      fonts = {
        names = [
          "Fira Mono Nerd Font"
        ];
        size = 12.0;
      };

      bars = [
        {
          command = lib.getExe config.programs.waybar.package;
          fonts = {
            names = [
              "Fira Mono Nerd Font"
            ];
            size = 12.0;
          };
        }
      ];

      output = {
        "DP-5" = {
          position = "0,0";
        };
        "DP-6" = {
          position = "2560,360";
        };
        "eDP-1" = {
          position = "-2560,0";
        };
      };

      workspaceOutputAssign = [
        {
          output = "DP-5";
          workspace = "1";
        }
        {
          output = "DP-6";
          workspace = "2";
        }
        {
          output = "eDP-1";
          workspace = "3";
        }
      ];

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${mod}+o" = "exec ${lib.getExe pkgs.kickoff}";
          "${mod}+Shift+s" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} copy area";
        };

    };
    extraConfig = ''
      bindswitch --reload --locked lid:on exec "[ $(swaymsg -t get_outputs | jq '. | length') -gt 1 ] && swaymsg output eDP-1 disable"
      bindswitch --reload --locked lid:off output eDP-1 enable
    '';
  };
}
