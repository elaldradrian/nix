{
  plugins.mini.modules.move = {
    mappings = { };
    options.reindent_linewise = true;
  };
  keymaps = [
    # Move selection
    {
      mode = [
        "x"
      ];
      key = "<M-h>";
      action = "<cmd>lua MiniMove.move_selection(\"left\")<cr>";
      options = {
        desc = "Move selection left";
      };
    }
    {
      mode = [
        "x"
      ];
      key = "<M-j>";
      action = "<cmd>lua MiniMove.move_selection(\"up\")<cr>";
      options = {
        desc = "Move selection up";
      };
    }
    {
      mode = [
        "x"
      ];
      key = "<M-l>";
      action = "<cmd>lua MiniMove.move_selection(\"down\")<cr>";
      options = {
        desc = "Move selection down";
      };
    }
    {
      mode = [
        "x"
      ];
      key = "<M-l>";
      action = "<cmd>lua MiniMove.move_selection(\"right\")<cr>";
      options = {
        desc = "Move selection right";
      };
    }

    {
      mode = [
        "x"
      ];
      key = "<M-left>";
      action = "<cmd>lua MiniMove.move_selection(\"left\")<cr>";
      options = {
        desc = "Move selection left";
      };
    }
    {
      mode = [
        "x"
      ];
      key = "<M-up>";
      action = "<cmd>lua MiniMove.move_selection(\"up\")<cr>";
      options = {
        desc = "Move selection up";
      };
    }
    {
      mode = [
        "x"
      ];
      key = "<M-down>";
      action = "<cmd>lua MiniMove.move_selection(\"down\")<cr>";
      options = {
        desc = "Move selection down";
      };
    }
    {
      mode = [
        "x"
      ];
      key = "<M-right>";
      action = "<cmd>lua MiniMove.move_selection(\"right\")<cr>";
      options = {
        desc = "Move selection right";
      };
    }
    # Move line
    {
      mode = [
        "n"
      ];
      key = "<M-h>";
      action = "<cmd>lua MiniMove.move_line(\"left\")<cr>";
      options = {
        desc = "Move line left";
      };
    }
    {
      mode = [
        "n"
      ];
      key = "<M-j>";
      action = "<cmd>lua MiniMove.move_line(\"up\")<cr>";
      options = {
        desc = "Move selection up";
      };
    }
    {
      mode = [
        "n"
      ];
      key = "<M-l>";
      action = "<cmd>lua MiniMove.move_line(\"down\")<cr>";
      options = {
        desc = "Move selection down";
      };
    }
    {
      mode = [
        "n"
      ];
      key = "<M-l>";
      action = "<cmd>lua MiniMove.move_line(\"right\")<cr>";
      options = {
        desc = "Move selection right";
      };
    }

    {
      mode = [
        "n"
      ];
      key = "<M-left>";
      action = "<cmd>lua MiniMove.move_line(\"left\")<cr>";
      options = {
        desc = "Move selection left";
      };
    }
    {
      mode = [
        "n"
      ];
      key = "<M-up>";
      action = "<cmd>lua MiniMove.move_line(\"up\")<cr>";
      options = {
        desc = "Move selection up";
      };
    }
    {
      mode = [
        "n"
      ];
      key = "<M-down>";
      action = "<cmd>lua MiniMove.move_line(\"down\")<cr>";
      options = {
        desc = "Move selection down";
      };
    }
    {
      mode = [
        "n"
      ];
      key = "<M-right>";
      action = "<cmd>lua MiniMove.move_line(\"right\")<cr>";
      options = {
        desc = "Move selection right";
      };
    }
  ];
}
