{
  pkgs,
  ...
}:
let
  kulala-http = pkgs.tree-sitter.buildGrammar {
    language = "kulala_http";
    version = "5.3.2";
    src = pkgs.fetchFromGitHub {
      owner = "mistweaverco";
      repo = "kulala.nvim";
      rev = "6656c9d332735ca6a27725e0fb45a1715c4372d9";
      hash = "sha256-e+6kEOW0lCFYgaju6DWeDHkX28wplR0H5O8T7nOWWjU=";
    };
    location = "lua/tree-sitter";

    meta.homepage = "https://github.com/mistweaverco/kulala.nvim";
  };
in
{
  extraPackages = with pkgs; [
    websocat
  ];

  plugins = {
    treesitter = {
      grammarPackages = [
        kulala-http
      ];
    };
    kulala = {
      enable = true;
      lazyLoad.settings.ft = "http";
      settings = {
        ui.disable_script_print_output = 327680;
        display_mode = "split";
        split_direction = "horizontal";
        default_view = "headers_body";
        debug = true;
      };
    };
  };
  keymaps = [
    # Sending
    {
      mode = "n";
      key = "<leader>hr";
      action = "<cmd>lua require('kulala').run()<cr>";
      options = {
        desc = "Run request";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ha";
      action = "<cmd>lua require('kulala').run_all()<cr>";
      options = {
        desc = "Run all requests";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hh";
      action = "<cmd>lua require('kulala').replay()<cr>";
      options = {
        desc = "Replay last request";
        silent = true;
      };
    }
    # UI
    {
      mode = "n";
      key = "<leader>ho";
      action = "<cmd>lua require('kulala').open()<cr>";
      options = {
        desc = "Open Kulala UI";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ht";
      action = "<cmd>lua require('kulala').toggle_view()<cr>";
      options = {
        desc = "Toggle headers/body view";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hs";
      action = "<cmd>lua require('kulala').show_stats()<cr>";
      options = {
        desc = "Show stats for the last request";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hq";
      action = "<cmd>lua require('kulala').close()<cr>";
      options = {
        desc = "Close Kulala window";
        silent = true;
      };
    }
    # Navigation
    {
      mode = "n";
      key = "[r";
      action = "<cmd>lua require('kulala').jump_prev()<cr>";
      options = {
        desc = "Jump to the previous request";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "]r";
      action = "<cmd>lua require('kulala').jump_next()<cr>";
      options = {
        desc = "Jump to the next request";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hf";
      action = "<cmd>lua require('kulala').search()<cr>";
      options = {
        desc = "Search named requests";
        silent = true;
      };
    }
    # Inspect
    {
      mode = "n";
      key = "<leader>hi";
      action = "<cmd>lua require('kulala').inspect()<cr>";
      options = {
        desc = "Inspect the current request";
        silent = true;
      };
    }
    # Clipboard
    {
      mode = "n";
      key = "<leader>hy";
      action = "<cmd>lua require('kulala').copy()<cr>";
      options = {
        desc = "Copy as curl command";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hp";
      action = "<cmd>lua require('kulala').from_curl()<cr>";
      options = {
        desc = "Paste curl from clipboard as http request";
        silent = true;
      };
    }
    # Environment
    {
      mode = "n";
      key = "<leader>he";
      action = "<cmd>lua require('kulala').set_selected_env()<cr>";
      options = {
        desc = "Select environment";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hj";
      action = "<cmd>lua require('kulala').open_cookies_jar()<cr>";
      options = {
        desc = "Open cookies jar";
        silent = true;
      };
    }
    # GraphQL
    {
      mode = "n";
      key = "<leader>hg";
      action = "<cmd>lua require('kulala').download_graphql_schema()<cr>";
      options = {
        desc = "Download GraphQL schema";
        silent = true;
      };
    }
    # Utility
    {
      mode = "n";
      key = "<leader>hb";
      action = "<cmd>lua require('kulala').scratchpad()<cr>";
      options = {
        desc = "Open scratchpad";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hx";
      action = "<cmd>lua require('kulala').scripts_clear_global()<cr>";
      options = {
        desc = "Clear global script variables";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>HX";
      action = "<cmd>lua require('kulala').clear_cached_files()<cr>";
      options = {
        desc = "Clear cached files";
        silent = true;
      };
    }
  ];
}
