{
  plugins.lualine = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";
    settings = {
      options = {
        globalstatus = true;
        theme = "nebulous";
      };
      tabline = {
        lualine_a = [
          {
            __unkeyed = "grapple";
            separator.left = ">";
            separator.right = "";
          }
        ];
        lualine_z = [
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
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "selectioncount";
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_b = [
          {
            __unkeyed = "branch";
            icon.__unkeyed = "";
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "filename";
            path = 1;
            symbols = {
              modified = "";
              readonly = "👁️";
              unnamed = "";
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
            __unkeyed = "lsp_status";
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_z = [
          {
            __unkeyed = "location";
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "progress";
            separator.left = "";
            separator.right = "";
          }
        ];
      };
    };
  };
}
