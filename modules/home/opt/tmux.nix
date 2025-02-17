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
      bind-key -n 'C-left' if-shell "$is_vim" 'send-keys C-left'  'select-pane -L'
      bind-key -n 'C-down' if-shell "$is_vim" 'send-keys C-down'  'select-pane -D'
      bind-key -n 'C-up' if-shell "$is_vim" 'send-keys C-up'  'select-pane -U'
      bind-key -n 'C-right' if-shell "$is_vim" 'send-keys C-right'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-left' select-pane -L
      bind-key -T copy-mode-vi 'C-down' select-pane -D
      bind-key -T copy-mode-vi 'C-up' select-pane -U
      bind-key -T copy-mode-vi 'C-right' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
