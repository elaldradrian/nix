{
  plugins.diffview = {
    enable = true;
    settings.keymaps.file_panel = [
      {
        action = "<cmd>tabc<cr>";
        description = "Close Diff View";
        key = "q";
        mode = "n";
      }
    ];
  };
}
