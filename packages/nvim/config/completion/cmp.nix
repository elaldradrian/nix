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
          priority = 700;
        }
        {
          name = "path";
          groupIndex = 2;
          priority = 600;
        }
        {
          name = "treesitter";
          groupIndex = 2;
          priority = 500;
        }
        {
          name = "spell";
          groupIndex = 2;
          priority = 400;
        }
        {
          name = "buffer";
          groupIndex = 2;
          priority = 200;
        }
        {
          name = "rg";
          groupIndex = 3;
          priority = 100;
        }
        {
          name = "luasnip";
          groupIndex = 3;
          priority = 300;
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
                  ["<C-space>"] = cmp.mapping.complete(),
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
        "<C-down>" = "cmp.mapping.select_next_item()";
        "<C-up>" = "cmp.mapping.select_prev_item()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-u>" = "cmp.mapping.scroll_docs(4)";
        "<C-space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
      };
    };
  };
}
