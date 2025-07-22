{
  plugins.rest = {
    enable = true;
    enableHttpFiletypeAssociation = true;
    enableTelescope = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>hr";
      action = "<cmd>Rest run<cr>";
      options = {
        desc = "Toggle between body and headers";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>hl";
      action = "<cmd>Rest last<cr>";
      options = {
        desc = "Inspect the current request";
        silent = true;
      };
    }
  ];
}
