{
  plugins.blink-cmp-dictionary.enable = true;
  plugins.blink-cmp-git.enable = true;
  plugins.blink-emoji.enable = true;
  plugins.blink-cmp-spell.enable = true;
  plugins.blink-ripgrep.enable = true;

  plugins.blink-cmp = {
    enable = true;
    settings = {
      completion = {
        menu.draw.columns = {
          __unkeyed-1 = {
            __unkeyed = "kind_icon";
          };

          __unkeyed-2 = {
            __unkeyed-1 = "label";
            __unkeyed-2 = "label_description";
            gap = 1;
          };
        };
        list.selection = {
          auto_insert = false;
          preselect = true;
        };
      };
      keymap = {
        preset = "none";
        "<tab>" = [
          "accept"
          "select_next"
          "fallback"
        ];
        "<c-up>" = [
          "select_prev"
          "fallback"
        ];
        "<c-k>" = [
          "select_prev"
          "fallback"
        ];
        "<c-down>" = [
          "select_next"
          "fallback"
        ];
        "<c-j>" = [
          "select_next"
          "fallback"
        ];
        "<c-e>" = [
          "hide"
        ];
        "<c-b>" = [
          "scroll_documentation_up"
          "fallback"
        ];
        "<c-f>" = [
          "scroll_documentation_down"
          "fallback"
        ];
        "<c-K>" = [
          "show_signature"
          "hide_signature"
          "fallback"
        ];
        "<c-space>" = [
          "show_documentation"
          "hide_documentation"
        ];
      };
      sources = {
        default = [
          "lsp"
          "path"
          "buffer"
          "emoji"
          "spell"
          "ripgrep"
        ];
        providers = {
          emoji = {
            module = "blink-emoji";
            name = "Emoji";
            score_offset = 15;
            opts = {
              insert = true;
            };
          };
          spell = {
            module = "blink-cmp-spell";
            name = "Spell";
            score_offset = 100;
            opts = {
            };
          };
          ripgrep = {
            async = true;
            module = "blink-ripgrep";
            name = "Ripgrep";
            score_offset = -100;
            opts = {
              prefix_min_len = 3;
              context_size = 5;
              max_filesize = "1M";
              project_root_marker = ".git";
              project_root_fallback = true;
              search_casing = "--ignore-case";
              additional_rg_options = { };
              fallback_to_regex_highlighting = true;
              ignore_paths = { };
              additional_paths = { };
              debug = false;
            };
          };
        };
      };
    };
  };
}
