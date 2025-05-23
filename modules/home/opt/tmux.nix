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
    terminal = "tmux-256color";
    historyLimit = 50000;
    escapeTime = 0;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      tmuxPlugins.yank
      tmuxPlugins.sessionist
    ];
    extraConfig = ''
      set -as terminal-features 'xterm*:extkeys'
      set -g display-time 4000
      set -g status-interval 5
      set -g xterm-keys on
      set -s extended-keys on
      set-option -g renumber-windows on

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      # Move
      bind-key -n 'C-Left'  if-shell "$is_vim" { send-keys C-Left  } { if-shell -F '#{pane_at_left}'   {} { select-pane -L } }
      bind-key -n 'C-Down'  if-shell "$is_vim" { send-keys C-Down  } { if-shell -F '#{pane_at_bottom}' {} { select-pane -D } }
      bind-key -n 'C-Up'    if-shell "$is_vim" { send-keys C-Up    } { if-shell -F '#{pane_at_top}'    {} { select-pane -U } }
      bind-key -n 'C-Right' if-shell "$is_vim" { send-keys C-Right } { if-shell -F '#{pane_at_right}'  {} { select-pane -R } }

      bind-key -T copy-mode-vi 'C-Left'  if-shell -F '#{pane_at_left}'   {} { select-pane -L }
      bind-key -T copy-mode-vi 'C-Down'  if-shell -F '#{pane_at_bottom}' {} { select-pane -D }
      bind-key -T copy-mode-vi 'C-Up'    if-shell -F '#{pane_at_top}'    {} { select-pane -U }
      bind-key -T copy-mode-vi 'C-Right' if-shell -F '#{pane_at_right}'  {} { select-pane -R }

      bind-key -n 'M-C-Left'  resize-pane -L 2
      bind-key -n 'M-C-Down'  resize-pane -D 2
      bind-key -n 'M-C-Up'    resize-pane -U 2
      bind-key -n 'M-C-Right' resize-pane -R 2

      bind-key -n 'M-C-c' new-window -c "#{pane_current_path}"
      bind-key -n 'M-C-s' split-window -c "#{pane_current_path}"
      bind-key -n 'M-C-v' split-window -h -c "#{pane_current_path}"

      bind-key -n 'M-C-PageDown' swap-pane -D
      bind-key -n 'M-C-PageUp'   swap-pane -U

      bind-key -n 'M-C-t' list-sessions
    '';
  };
}
