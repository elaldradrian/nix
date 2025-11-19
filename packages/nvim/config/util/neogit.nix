{
  plugins.neogit = {
    enable = true;
    lazyLoad.settings.cmd = "Neogit";
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action = ":Neogit<CR>";
      #    lua = true;
      options = {
        silent = true;
        desc = "Neogit";
      };
    }
  ];
}
