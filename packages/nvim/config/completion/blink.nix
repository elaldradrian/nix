{
  plugins.blink-cmp = {
    enable = true;
    settings.sources = {
      default = [
        "lsp"
        "path"
        "luasnip"
        "buffer"
        "dictionary"
        "emoji"
        "git"
        "spell"
        "ripgrep"
      ];
      providers = {
        dictionary = {
          module = "blink-cmp-dictionary";
          name = "Dict";
          score_offset = 100;
          min_keyword_length = 3;
        };
        emoji = {
          module = "blink-emoji";
          name = "Emoji";
          score_offset = 15;
          opts = {
            insert = true;
          };
        };
        git = {
          module = "blink-cmp-git";
          name = "git";
          score_offset = 100;
          opts = {
            commit = { };
            git_centers = {
              git_hub = { };
            };
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
          score_offset = 100;
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
}
