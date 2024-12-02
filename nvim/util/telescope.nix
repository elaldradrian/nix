{
  plugins.telescope = {
    enable = true;
    extensions = {
      file-browser = {
        enable = true;
      };
      ui-select = {
        enable = true;
      };
      frecency = {
        enable = true;
      };
      fzf-native = {
        enable = true;
      };
    };
    settings = {
      defaults = {
        layout_config = {
          horizontal = {
            prompt_position = "top";
          };
        };
        sorting_strategy = "ascending";
      };
      pickers = {
        colorscheme = {
          enable_preview = true;
        };
      };
      mappings = {
        # This is not working, use Alt + the key instead 🤷
        n = {
          "d" = {
            __raw = "require('telescope.actions').delete_buffer";
          };
          "q" = {
            __raw = "require('telescope.actions').close";
          };
        };
      };
    };
    keymaps = {
      "<leader><space>" = {
        action = "git_files";
        options = {
          desc = "Search git files";
        };
      };
      "<leader>/" = {
        action = "live_grep";
        options = {
          desc = "Live Grep Project";
        };
      };
      "<leader><Tab>" = {
        action = "resume";
        options = {
          desc = "Resume";
        };
      };
      "<leader>fr" = {
        action = "oldfiles";
        options = {
          desc = "Recent";
        };
      };
      "<leader>fb" = {
        action = "buffers";
        options = {
          desc = "Buffers";
        };
      };
      "<leader>fp" = {
        action = "find_files";
        options = {
          desc = "Find Project File";
        };
      };
      "<leader>gc" = {
        action = "git_commits";
        options = {
          desc = "Commits";
        };
      };
      "<leader>gs" = {
        action = "git_status";
        options = {
          desc = "Status";
        };
      };
      "<leader>sa" = {
        action = "autocommands";
        options = {
          desc = "Auto Commands";
        };
      };
      "<leader>sb>" = {
        action = "current_buffer_fuzzy_find";
        options = {
          desc = "Fuzzy Current Buffer";
        };
      };
      "<leader>sc" = {
        action = "command_history";
        options = {
          desc = "Command History";
        };
      };
      "<leader>sC" = {
        action = "commands";
        options = {
          desc = "Commands";
        };
      };
      "<leader>sD" = {
        action = "diagnostics";
        options = {
          desc = "Workspace diagnostics";
        };
      };
      "<leader>sh" = {
        action = "help_tags";
        options = {
          desc = "Help pages";
        };
      };
      "<leader>sH" = {
        action = "highlights";
        options = {
          desc = "Search Highlight Groups";
        };
      };
      "<leader>sk" = {
        action = "keymaps";
        options = {
          desc = "Keymaps";
        };
      };
      "<leader>sM" = {
        action = "man_pages";
        options = {
          desc = "Man pages";
        };
      };
      "<leader>sm" = {
        action = "marks";
        options = {
          desc = "Jump to Mark";
        };
      };
      "<leader>so" = {
        action = "vim_options";
        options = {
          desc = "Options";
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>sd";
      action = "<cmd>Telescope diagnostics bufnr=0<cr>";
      options = {
        desc = "Document diagnostics";
      };
    }
    {
      mode = "n";
      key = "<leader>ff";
      action.__raw = ''
        function()
            require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
          end
      '';
      options.desc = "Search File Cwd";
    }
    {
      mode = "n";
      key = "<leader>sg";
      action.__raw = ''
        function()
           require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:p:h") })
          end
      '';
      options.desc = "Grep Cwd";
    }
  ];
}
