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
  config = lib.mkIf config.opt.features.desktop.enable {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      xwayland = true;
      config = {
        modifier = mod;
        terminal = lib.getExe pkgs.kitty;
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

        input = {
          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
            scroll_factor = "0.7";
          };
          "type:keyboard" = {
            xkb_options = "caps:escape";
          };
        };

        output = {
          "eDP-1" = {
            position = "0,0";
          };
          "DP-5" = {
            position = "1440,0";
          };
          "DP-6" = {
            position = "4000,0";
          };
        };

        # workspaceOutputAssign = [
        #   {
        #     output = "DP-5";
        #     workspace = "1";
        #   }
        #   {
        #     output = "DP-6";
        #     workspace = "2";
        #   }
        #   {
        #     output = "eDP-1";
        #     workspace = "3";
        #   }
        # ];

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

        # Brightness
        bindsym XF86MonBrightnessDown exec light -U 10
        bindsym XF86MonBrightnessUp exec light -A 10

        # Volume
        bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
        bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
        bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
      '';
    };
  };
}
