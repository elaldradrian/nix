{
  plugins.lspsaga = {
    enable = true;
    settings = {
      beacon = {
        enable = true;
      };
      ui = {
        border = "rounded";
        codeAction = "💡";
      };
      hover = {
        openCmd = "!chrome";
        openLink = "gx";
      };
      diagnostic = {
        borderFollow = true;
        diagnosticOnlyCurrent = false;
        showCodeAction = true;
      };
      symbolInWinbar = {
        enable = false;
      };
      codeAction = {
        extendGitSigns = false;
        showServerName = true;
        onlyInCursor = true;
        numShortcut = true;
        keys = {
          exec = "<CR>";
          quit = [
            "<Esc>"
            "q"
          ];
        };
      };
      implement = {
        enable = false;
      };
      rename = {
        autoSave = true;
        inSelect = false;
      };
      outline = {
        autoClose = true;
        autoPreview = true;
        closeAfterJump = true;
        layout = "normal"; # normal or float
        winPosition = "right"; # left or right
        keys = {
          jump = "e";
          quit = "q";
          toggleOrJump = "o";
        };
      };
      scrollPreview = {
        scrollDown = "<C-f>";
        scrollUp = "<C-b>";
      };
      lightbulb.virtualText = false;
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "gd";
      action = "<cmd>Lspsaga goto_definition<CR>";
      options = {
        desc = "Goto Definition";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gD";
      action = "<cmd>Lspsaga goto_type_definition<CR>";
      options = {
        desc = "Type Definition";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gr";
      action = "<cmd>Lspsaga finder ref<CR>";
      options = {
        desc = "References";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "K";
      action = "<cmd>Lspsaga hover_doc<CR>";
      options = {
        desc = "Hover";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>cr";
      action = "<cmd>Lspsaga rename<CR>";
      options = {
        desc = "Rename";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>Lspsaga code_action<CR>";
      options = {
        desc = "Code Action";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>cd";
      action = "<cmd>Lspsaga show_line_diagnostics<CR>";
      options = {
        desc = "Line Diagnostics";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "[d";
      action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
      options = {
        desc = "Previous Diagnostic";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "]d";
      action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
      options = {
        desc = "Next Diagnostic";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "[e";
      action.__raw = # lua
        ''
          function()
            require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
      options = {
        desc = "Next Error";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "]e";
      action.__raw = # lua
        ''
          function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
      options = {
        desc = "Previous Error";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "[w";
      action.__raw = # lua
        ''
          function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
          end
        '';
      options = {
        desc = "Next Warning";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "]w";
      action.__raw = # lua
        ''
          function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
          end
        '';
      options = {
        desc = "Previous Warning";
        silent = true;
      };
    }
  ];
}
