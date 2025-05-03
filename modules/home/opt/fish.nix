{
  pkgs,
  ...
}:
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
    interactiveShellInit = # fish
      ''
        # Vi keybindings and cursor settings
        fish_vi_key_bindings
        set fish_vi_force_cursor 1
        set fish_cursor_default block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_replace underscore
        set fish_cursor_external line
        set fish_cursor_visual block

        # Function to rename tmux session based on git repo
        function rename_tmux_session_by_git --description "Rename tmux session based on git repo"
          if test -n "$TMUX"
            set git_root (command git rev-parse --show-toplevel 2> /dev/null)
            if test -n "$git_root"
              set git_name (basename $git_root)
              set current_session (tmux display-message -p '#S')
              if test "$current_session" != "$git_name"
                tmux rename-session $git_name
              end
            end
          end
        end

        # Call the function on every prompt
        function fish_prompt
          rename_tmux_session_by_git
          echo -n (prompt_pwd) '> '
        end
      '';
  };
}
