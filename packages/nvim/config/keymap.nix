{
  globals.mapleader = " ";

  keymaps = [
    # Clear search
    {
      mode = "n";
      key = "<esc>";
      action = "<cmd>nohl<CR>";
      options = {
        desc = "Clear search";
      };
    }
    # Change window
    {
      mode = "n";
      key = "<C-left>";
      action = "<C-w>h";
      options = {
        desc = "Go to Left Window";
      };
    }
    {
      mode = "n";
      key = "<C-down>";
      action = "<C-w>j";
      options = {
        desc = "Go to Lower Window";
      };
    }
    {
      mode = "n";
      key = "<C-up>";
      action = "<C-w>k";
      options = {
        desc = "Go to Upper Window";
      };
    }
    {
      mode = "n";
      key = "<C-right>";
      action = "<C-w>l";
      options = {
        desc = "Go to Right Window";
      };
    }
    # Categories
    {
      mode = "n";
      key = "<leader>f";
      action = "+find/file";
      options = {
        desc = "+file/file";
      };
    }
    {
      mode = "n";
      key = "<leader>s";
      action = "+search";
      options = {
        desc = "+search";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>g";
      action = "+git";
      options = {
        desc = "+git";
      };
    }
    {
      mode = "n";
      key = "<leader>u";
      action = "+ui";
      options = {
        desc = "+ui";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>c";
      action = "+code";
      options = {
        desc = "+code";
      };
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-W>h";
      options = {
        silent = true;
        desc = "Move to window left";
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-W>j";
      options = {
        silent = true;
        desc = "Move to window bellow";
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-W>k";
      options = {
        silent = true;
        desc = "Move to window over";
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-W>l";
      options = {
        silent = true;
        desc = "Move to window right";
      };
    }
    {
      mode = "n";
      key = "<C-s>";
      action = "<cmd>w<cr><esc>";
      options = {
        silent = true;
        desc = "Save file";
      };
    }
    # Quit
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>quitall<cr><esc>";
      options = {
        silent = true;
        desc = "Quit all";
      };
    }
    {
      mode = "n";
      key = "<leader>ul";
      action = ":lua ToggleLineNumber()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Numbers";
      };
    }
    {
      mode = "n";
      key = "<leader>uw";
      action = ":lua ToggleWrap()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Wrap";
      };
    }
    # {
    #   mode = "n";
    #   key = "J";
    #   action = "mzJ`z";
    #   options = {
    #     desc = "Allow cursor to stay in the same place after appending to current line";
    #   };
    # }
    {
      mode = "n";
      key = "<Tab>";
      action = "<CMD>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal<CR>";
      options = {
        desc = "Next buffer";
      };
    }
  ];
  # extraConfigLua = # Lua
  #   ''
  #     function ToggleLineNumber()
  #       if vim.wo.number then
  #         vim.wo.number = false
  #       else
  #         vim.wo.number = true
  #         vim.wo.relativenumber = false
  #       end
  #     end
  #
  #     function ToggleWrap()
  #       vim.wo.wrap = not vim.wo.wrap
  #     end
  #   '';
}
