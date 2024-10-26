{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = {
          normal = {
            a = {
              bg = "#nil";
            };
            b = {
              bg = "nil";
            };
            c = {
              bg = "nil";
            };
            z = {
              bg = "nil";
            };
            y = {
              bg = "nil";
            };
          };
        };
        globalstatus = true;
      };
      tabline = {
        lualine_a = [
          {
            __unkeyed = "grapple";
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_b = [
          {
            __unkeyed.__raw = "function() return require(\"lspsaga.symbol.winbar\").get_bar() end";
            separator.left = "";
            separator.right = "";
          }
        ];

      };
      sections = {
        lualine_a = [
          # { __unkeyed = "grapple"; }
          {
            __unkeyed = "mode";
            fmt = "string.lower";
            color = {
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_b = [
          {
            __unkeyed = "branch";
            icon.__unkeyed = "";
            color = {
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "diff";
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_c = [
          {
            __unkeyed = "diagnostics";
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = "󰝶 ";
            };
            color = {
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_x = [
          {
            __unkeyed.__raw = "function() return require(\"noice\").api.status.mode.get() end";
            cond.__raw = "function() return package.loaded[\"noice\"] and require(\"noice\").api.status.mode.has() end";
          }
        ];
        lualine_y = [
          {
            __unkeyed = "filetype";
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "filename";
            symbols = {
              modified = "";
              readonly = "👁️";
              unnamed = "";
            };
            color = {
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_z = [
          {
            __unkeyed = "location";
            color = {
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
        ];
      };
    };
  };
}
