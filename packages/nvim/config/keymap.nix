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
    # {
    #   mode = "n";
    #   key = "<C-left>";
    #   action = "<C-w>h";
    #   options = {
    #     desc = "Go to Left Window";
    #   };
    # }
    # {
    #   mode = "n";
    #   key = "<C-down>";
    #   action = "<C-w>j";
    #   options = {
    #     desc = "Go to Lower Window";
    #   };
    # }
    # {
    #   mode = "n";
    #   key = "<C-up>";
    #   action = "<C-w>k";
    #   options = {
    #     desc = "Go to Upper Window";
    #   };
    # }
    # {
    #   mode = "n";
    #   key = "<C-right>";
    #   action = "<C-w>l";
    #   options = {
    #     desc = "Go to Right Window";
    #   };
    # }
    # Resize window
    {
      mode = "n";
      key = "<S-left>";
      action = "<cmd>vertical resize -2<cr>";
      options = {
        desc = "Decrease Window Width";
      };
    }
    {
      mode = "n";
      key = "<S-down>";
      action = "<cmd>resize -2<cr>";
      options = {
        desc = "Decrease Window Height";
      };
    }
    {
      mode = "n";
      key = "<S-up>";
      action = "<cmd>resize +2<cr>";
      options = {
        desc = "Increase Window Height";
      };
    }
    {
      mode = "n";
      key = "<S-right>";
      action = "<cmd>vertical resize +2<cr>";
      options = {
        desc = "Increase Window Width";
      };
    }
    # Close window
    {
      mode = "n";
      key = "<C-q>";
      action = "<C-w>q";
      options = {
        desc = "Close Window";
      };
    }
    # Move between windows
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
    # Save
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
    # Toggle line numbers
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
      action = ":set wrap!<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Wrap";
      };
    }
    {
      mode = "n";
      key = "<leader><CR>";
      action = "<CMD>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal<CR>";
      options = {
        desc = "Next buffer";
      };
    }
    # up and down
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Down>";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        silent = true;
        desc = "Move down";
        expr = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Up>";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        silent = true;
        desc = "Move up";
        expr = true;
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
