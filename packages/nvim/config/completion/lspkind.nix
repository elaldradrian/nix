{
  plugins.lspkind = {
    enable = true;
    symbolMap = {
      Copilot = " ";
    };
    extraOptions = {
      maxwidth = 50;
      ellipsis_char = "...";
    };

    cmp = {
      enable = true;

      menu = {
        emoji = "[EMOJI]";
        nvim_lsp = "[LSP]";
        path = "[PATH]";
        treesitter = "[TS]";
        spell = "[SPELL]";
        buffer = "[BUFFER]";
        rg = "[RG]";
        luasnip = "[SNIP]";

        git = "[GIT]";
        conventionalcommits = "[COMMIG]";
      };
    };
  };
}
