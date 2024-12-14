{
  plugins.flash = {
    enable = true;
    settings = {
      labels = "arstgmneiobpfluykhvd";
    };
  };
  keymaps = [
    # Jump
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action.__raw = # Lua
        ''
          function()
            require('flash').jump({
              jump = {
                autojump = true
              },
              label = {
                rainbow = { enabled = true },
              }
            })
          end
        '';
      options = {
        desc = "Flash";
      };
    }
    # Jump to blank line
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "[<space>";
      action.__raw = # Lua
        ''
          function()
            require('flash').jump({
              search = {
                mode = "search",
                max_length = 0,
                forward = false
              },
              jump = {
                autojump = true
              },
              label = {
                rainbow = { enabled = true },
                after = false,
                before = { 0, 0 }
              },
              highlight = {
                backdrop = false,
                matches = false
              },
              pattern = "^\\n"
            })
          end
        '';
      options = {
        desc = "Flash to previous blank line";
      };
    }

    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "]<space>";
      action.__raw = # Lua
        ''
          function()
            require('flash').jump({
              search = {
                mode = "search",
                max_length = 0
              },
              jump = {
                autojump = true
              },
              label = {
                rainbow = { enabled = true },
                after = false,
                before = { 0, 0 }
              },
              highlight = {
                backdrop = false,
                matches = false
              },
              pattern = "^\\n"
            })
          end
        '';
      options = {
        desc = "Flash to next blank line";
      };
    }
    # Select outer tresitter node
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "S";
      action = "<cmd>lua require('flash').treesitter()<cr>";
      options = {
        desc = "Flash Treesitter";
      };
    }
    {
      mode = "o";
      key = "r";
      action = "<cmd>lua require('flash').remote()<cr>";
      options = {
        desc = "Remote Flash";
      };
    }
    {
      mode = [
        "x"
        "o"
      ];
      key = "R";
      action = "<cmd>lua require('flash').treesitter_search()<cr>";
      options = {
        desc = "Treesitter Search";
      };
    }
  ];

}
