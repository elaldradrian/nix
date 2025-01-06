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
      config = {
        load_dotenv = true;
      };
    };
    git = {
      enable = true;
      userEmail = "rune@dahl-billeskov.com";
      userName = "Rune Dahl Billeskov";
    };
  };
}
