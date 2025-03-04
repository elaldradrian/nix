{
  lib,
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    newSession = true;
    shell = lib.getExe pkgs.fish;
    shortcut = "t";
    escapeTime = 0;
    plugins = with pkgs; [
      tmuxPlugins.resurrect
    ];
    extraConfig = ''
      set -g default-terminal tmux-256color
      set -g xterm-keys on
      set -as terminal-features 'xterm*:extkeys'
      set -s extended-keys on
      set-option -g renumber-windows on

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-left'  if-shell "$is_vim" { send-keys C-left  } { if-shell -F '#{pane_at_left}'   {} { select-pane -L } }
      bind-key -n 'C-down'  if-shell "$is_vim" { send-keys C-down  } { if-shell -F '#{pane_at_bottom}' {} { select-pane -D } }
      bind-key -n 'C-up'    if-shell "$is_vim" { send-keys C-up    } { if-shell -F '#{pane_at_top}'    {} { select-pane -U } }
      bind-key -n 'C-right' if-shell "$is_vim" { send-keys C-right } { if-shell -F '#{pane_at_right}'  {} { select-pane -R } }

      bind-key -T copy-mode-vi 'C-left'  if-shell -F '#{pane_at_left}'   {} { select-pane -L }
      bind-key -T copy-mode-vi 'C-down'  if-shell -F '#{pane_at_bottom}' {} { select-pane -D }
      bind-key -T copy-mode-vi 'C-up'    if-shell -F '#{pane_at_top}'    {} { select-pane -U }
      bind-key -T copy-mode-vi 'C-right' if-shell -F '#{pane_at_right}'  {} { select-pane -R }

      bind c new-window -c "#{pane_current_path}"
      bind s split-window -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"

      bind -n M-S-Up swap-pane -U
      bind -n M-S-Down swap-pane -D

      bind -n M-S-h swap-pane -L
      bind -n M-S-l swap-pane -R
      bind -n M-S-k swap-pane -U
      bind -n M-S-j swap-pane -D
    '';
  };
}
