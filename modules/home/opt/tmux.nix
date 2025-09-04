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

      # Enter copy mode with Prefix+v
      bind v copy-mode
      unbind [

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"

      # Move
      bind-key -n 'C-Left'  if-shell "$is_vim" { send-keys C-Left  } { if-shell -F '#{pane_at_left}'   {} { select-pane -L } }
      bind-key -n 'C-Down'  if-shell "$is_vim" { send-keys C-Down  } { if-shell -F '#{pane_at_bottom}' {} { select-pane -D } }
      bind-key -n 'C-Up'    if-shell "$is_vim" { send-keys C-Up    } { if-shell -F '#{pane_at_top}'    {} { select-pane -U } }
      bind-key -n 'C-Right' if-shell "$is_vim" { send-keys C-Right } { if-shell -F '#{pane_at_right}'  {} { select-pane -R } }

      bind-key -n 'C-h'  if-shell "$is_vim" { send-keys C-h  } { if-shell -F '#{pane_at_left}'   {} { select-pane -L } }
      bind-key -n 'C-j'  if-shell "$is_vim" { send-keys C-j  } { if-shell -F '#{pane_at_bottom}' {} { select-pane -D } }
      bind-key -n 'C-k'    if-shell "$is_vim" { send-keys C-k    } { if-shell -F '#{pane_at_top}'    {} { select-pane -U } }
      bind-key -n 'C-l' if-shell "$is_vim" { send-keys C-l } { if-shell -F '#{pane_at_right}'  {} { select-pane -R } }

      # In copy-mode, we need to use different bindings
      # bind-key -T copy-mode-vi 'C-Left'  if-shell -F '#{pane_at_left}'   {} { select-pane -L }
      # bind-key -T copy-mode-vi 'C-Down'  if-shell -F '#{pane_at_bottom}' {} { select-pane -D }
      # bind-key -T copy-mode-vi 'C-Up'    if-shell -F '#{pane_at_top}'    {} { select-pane -U }
      # bind-key -T copy-mode-vi 'C-Right' if-shell -F '#{pane_at_right}'  {} { select-pane -R }

      # Vim-aware resize
      bind-key -n 'M-C-Left'  if-shell "$is_vim" { send-keys M-C-Left  } { resize-pane -L 2 }
      bind-key -n 'M-C-Down'  if-shell "$is_vim" { send-keys M-C-Down  } { resize-pane -D 2 }
      bind-key -n 'M-C-Up'    if-shell "$is_vim" { send-keys M-C-Up    } { resize-pane -U 2 }
      bind-key -n 'M-C-Right' if-shell "$is_vim" { send-keys M-C-Right } { resize-pane -R 2 }

      # Optional hjkl equivalents
      bind-key -n 'M-C-h' if-shell "$is_vim" { send-keys M-C-h } { resize-pane -L 2 }
      bind-key -n 'M-C-j' if-shell "$is_vim" { send-keys M-C-j } { resize-pane -D 2 }
      bind-key -n 'M-C-k' if-shell "$is_vim" { send-keys M-C-k } { resize-pane -U 2 }
      bind-key -n 'M-C-l' if-shell "$is_vim" { send-keys M-C-l } { resize-pane -R 2 }

      bind-key -n 'M-C-t' new-session -c "#{pane_current_path}"
      bind-key -n 'M-C-c' new-window -c "#{pane_current_path}"
      bind-key -n 'M-C-s' split-window -c "#{pane_current_path}"
      bind-key -n 'M-C-v' split-window -h -c "#{pane_current_path}"

      bind-key -n 'M-C-PageDown' swap-pane -D
      bind-key -n 'M-C-PageUp'   swap-pane -U

      bind-key -n 'M-C-l' choose-tree -s

      bind-key -n M-C-n next-window
      bind-key -n M-C-p previous-window

      set -g status-right '#{cpu_bg_color} CPU: #{cpu_icon} #{cpu_percentage} | %a %h-%d %H:%M '
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
    '';
  };
}
