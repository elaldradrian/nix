{
  pkgs,
  ...
}:
{
  programs = {
    fish = {
      enable = true;
      plugins = [
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
      interactiveShellInit = # Fish
        ''
          fish_vi_key_bindings
          set fish_vi_force_cursor 1
          set fish_cursor_default block
          set fish_cursor_insert line
          set fish_cursor_replace_one underscore
          set fish_cursor_replace underscore
          set fish_cursor_external line
          set fish_cursor_visual block
        '';
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
    git = {
      enable = true;
      userEmail = "rune@dahl-billeskov.com";
      userName = "Rune Dahl Billeskov";
    };
    wezterm = {
      enable = true;
      colorSchemes = {
        enur = {
          foreground = "#FFFFFF";
          background = "#000000";

          cursor_fg = "#000000";
          cursor_bg = "#FFFFFF";
          cursor_border = "#FFFFFF";

          selection_fg = "#FFFFFF";
          selection_bg = "#44475a";

          ansi = [
            "#000000"
            "#FF3C3C"
            "#00FF00"
            "#FFFF5A"
            "#4F9DFF"
            "#FF4FD8"
            "#4DFFFF"
            "#CCCCCC"
          ];
          brights = [
            "#7F7F7F"
            "#FF7373"
            "#32FF32"
            "#FFFF82"
            "#74AFFF"
            "#FF74E3"
            "#73FFFF"
            "#FFFFFF"
          ];
        };
      };
      extraConfig = # Lua
        ''
          return {
            color_scheme = "enur",
            front_end = "WebGpu"
          }
        '';
    };
    waybar.enable = true;
  };
}
