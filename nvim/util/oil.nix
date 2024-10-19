{
  plugins.oil = {
    enable = true;

    settings = {
      skip_confirm_for_simple_edits = true;
      view_options = {
        is_hidden_file.__raw = # Lua
          ''
            function(name)
              return name == ".." or name == ".git"
            end
          '';
      };
      view_options = {
        show_hidden = false;
      };
      win_options = {
        signcolumn = "yes:2";
      };
      columns = [
        "icon"
      ];

      use_default_keymaps = false;
      keymaps = {
        "g?" = "actions.show_help";
        "<CR>" = "actions.select";
        "<C-p>" = "actions.preview";
        "q" = "actions.close";
        "<C-r>" = "actions.refresh";
        "-" = "actions.parent";
        "_" = "actions.open_cwd";
        "`" = "actions.cd";
        "~" = {
          callback = "actions.cd";
          opts = {
            scope = "tab";
          };
          desc = ":tcd to the current oil directory";
        };
        "gs" = "actions.change_sort";
        "gx" = "actions.open_external";
        "g." = "actions.toggle_hidden";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = # Lua
        ''
          function()
            local oil = require("oil")

            oil.open()
            -- require("oil.util").run_after_load(0, function()
            --   oil.open_preview({ vertical = true, split = "botright" })
            -- end)
          end
        '';
      options = {
        desc = "Open Explorer";
      };
    }
  ];
}
