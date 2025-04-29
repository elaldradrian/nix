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
          priority = 1000;
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
          priority = 300;
        }
        {
          name = "luasnip";
          groupIndex = 3;
          priority = 100;
        }
      ];
      formatting = {
        fields = [
          "abbr"
          "menu"
          "kind"
        ];
      };
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
      mapping = {
        "<C-down>" = "cmp.mapping.select_next_item()";
        "<C-up>" = "cmp.mapping.select_prev_item()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-u>" = "cmp.mapping.scroll_docs(4)";
        "<C-space>" = "cmp.mapping.complete()";
        "<tab>" = "cmp.mapping.confirm({ select = true })";
        # "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
      };
    };
  };
}
