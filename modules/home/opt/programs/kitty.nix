{ pkgs, ... }:
{
  home.file.kitty-theme = {
    enable = true;
    target = ".config/kitty/themes/enur.conf";
    text = ''
      foreground #FFFFFF
      background #000000

      cursor #000000
      cursor_text #FFFFFF
      selection #44475a
      selection_text #FFFFFF

      color0 #000000
      color1 #FF3C3C
      color2 #00FF00
      color3 #FFFF5A
      color4 #4F9DFF
      color5 #FF4FD8
      color6 #4DFFFF
      color7 #CCCCCC
      color8 #7F7F7F
      color9 #FF7373
      color10 #32FF32
      color11 #FFFF82
      color12 #74AFFF
      color13 #FF74E3
      color14 #73FFFF
      color15 #FFFFFF
    '';
  };
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    font = {
      name = "Fira Code";
      size = 14;
    };
    settings = {
      shell = "${pkgs.tmux}/bin/tmux a";
    };
    extraConfig = ''
      map shift+enter send_text all \x1b[13;2u
    '';
  };
}
