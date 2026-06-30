{
  plugins.mini.modules.clue = {
    content = {
      hide = {
        buftype = [ ];
      };
    };
    window = {
      delay = 500;
      config = {
        border = "rounded";
        width.__raw = ''
          math.floor(0.318 * vim.o.columns)
        '';
        row = "auto";
        col = "auto";
        anchor = "se";
      };
    };
    triggers = [
      {
        mode = "n";
        keys = "<leader>";
      }
      {
        mode = "x";
        keys = "<leader>";
      }
      {
        mode = "i";
        keys = "<c-x>";
      }
      {
        mode = "n";
        keys = "g";
      }
      {
        mode = "x";
        keys = "g";
      }
      {
        mode = "n";
        keys = "'";
      }
      {
        mode = "n";
        keys = "`";
      }
      {
        mode = "n";
        keys = "]";
      }
      {
        mode = "n";
        keys = "[";
      }
      {
        mode = "x";
        keys = "'";
      }
      {
        mode = "x";
        keys = "`";
      }
      {
        mode = "n";
        keys = "\"";
      }
      {
        mode = "x";
        keys = "\"";
      }
      {
        mode = "i";
        keys = "<c-r>";
      }
      {
        mode = "c";
        keys = "<c-r>";
      }
      {
        mode = "n";
        keys = "<c-w>";
      }
      {
        mode = "n";
        keys = "z";
      }
      {
        mode = "x";
        keys = "z";
      }
    ];
    clues = [
      {
        mode = "n";
        keys = "<leader>f";
        desc = "+find/file";
      }
      {
        mode = "n";
        keys = "<leader>q";
        desc = "+quit/session";
      }
      {
        mode = "n";
        keys = "<leader>g";
        desc = "+git";
        postkeys = "<leader>g";
      }
      {
        mode = "n";
        keys = "<leader>u";
        desc = "+ui";
      }
      {
        mode = "n";
        keys = "<leader>c";
        desc = "+code";
      }
      {
        mode = "n";
        keys = "<leader>p";
        desc = "+pi";
      }
      { __raw = "require('mini.clue').gen_clues.builtin_completion()"; }
      { __raw = "require('mini.clue').gen_clues.g()"; }
      { __raw = "require('mini.clue').gen_clues.marks()"; }
      { __raw = "require('mini.clue').gen_clues.registers()"; }
      { __raw = "require('mini.clue').gen_clues.windows()"; }
      { __raw = "require('mini.clue').gen_clues.z()"; }
    ];
  };
}
