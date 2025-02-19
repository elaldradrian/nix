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

      bind-key -n 'C-left' if-shell "$is_vim" 'send-keys C-left'  'select-pane -L -o'
      bind-key -n 'C-down' if-shell "$is_vim" 'send-keys C-down'  'select-pane -D -o'
      bind-key -n 'C-up' if-shell "$is_vim" 'send-keys C-up'  'select-pane -U -o'
      bind-key -n 'C-right' if-shell "$is_vim" 'send-keys C-right'  'select-pane -R -o'

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-left' select-pane -L -o
      bind-key -T copy-mode-vi 'C-down' select-pane -D -o
      bind-key -T copy-mode-vi 'C-up' select-pane -U -o
      bind-key -T copy-mode-vi 'C-right' select-pane -R -o
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      bind c new-window -c "#{pane_current_path}"
      bind s split-window -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"

      bind -n M-S-Left swap-pane -L
      bind -n M-S-Right swap-pane -R
      bind -n M-S-Up swap-pane -U
      bind -n M-S-Down swap-pane -D

      bind -n M-S-h swap-pane -L
      bind -n M-S-l swap-pane -R
      bind -n M-S-k swap-pane -U
      bind -n M-S-j swap-pane -D
    '';
  };
}
