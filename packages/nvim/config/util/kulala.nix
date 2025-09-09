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
      rev = "6b6e1c8b538cce6654cfc5fb3e4a3acfa316ce57";
      hash = "sha256-cFjYRw93tR439RGSwNeBo3i4ep0jx/Jcfx9UTS32Tx8=";
    };
    location = "lua/tree-sitter";

    meta.homepage = "https://github.com/mistweaverco/kulala.nvim";
  };
in
{
  plugins = {
    treesitter = {
      grammarPackages = [
        kulala-http
      ];
    };
    kulala = {
      enable = true;
      settings = {
        display_mode = "split";
        split_direction = "horizontal";
        default_view = "headers_body";
        debug = true;
      };
    };
  };
  keymaps = [
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
      key = "<leader>hh";
      action = "<cmd>lua require('kulala').toggle_view()<cr>";
      options = {
        desc = "Toggle between body and headers";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hi";
      action = "<cmd>lua require('kulala').inspect()<cr>";
      options = {
        desc = "Inspect the current request";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hs";
      action = "<cmd>lua require('kulala').show_stats()<cr>";
      options = {
        desc = "Show stat for the last request";
        silent = true;
      };
    }
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
      key = "<leader>hy";
      action = "<cmd>lua require('kulala').copy()<cr>";
      options = {
        desc = "Copy the current request as a curl command";
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
  ];
}
