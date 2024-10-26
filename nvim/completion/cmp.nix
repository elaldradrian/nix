{
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = [
        {
          name = "emoji";
          groupIndex = 1;
        }
        {
          name = "nvim_lsp";
          groupIndex = 2;
        }
        {
          name = "spell";
          groupIndex = 2;
        }
        {
          name = "treesitter";
          groupIndex = 2;
        }
        {
          name = "buffer";
          groupIndex = 2;
        }
        {
          name = "path";
          groupIndex = 2;
        }
        {
          name = "rg";
          groupIndex = 3;
        }
        {
          name = "luasnip";
          groupIndex = 3;
        }
      ];

      filetype = {
        gitcommit = {
          sources = [
            { name = "conventionalcommits"; }
            { name = "git"; }
            { name = "emoji"; }
            { name = "path"; }
          ];
        };
      };

      cmdline =
        let
          common = {
            mapping.__raw = # lua
              ''
                cmp.mapping.preset.cmdline({
                  ["<C-Space>"] = cmp.mapping.complete(), -- Open list without typing
                })
              '';
            sources = [ { name = "buffer"; } ];
          };
        in
        {
          "/" = common;
          "?" = common;
          ":" = {
            inherit (common) mapping;
            sources = [
              {
                name = "path";
                option.trailing_slash = true;
              }
              { name = "cmdline"; }
            ];
          };
        };

      mapping = {
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<C-j>" = "cmp.mapping.select_next_item()";
        "<C-k>" = "cmp.mapping.select_prev_item()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
      };
    };
  };
}
