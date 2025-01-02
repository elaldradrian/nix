{
  plugins.diffview = {
    enable = true;
    keymaps.filePanel = [
      {
        action = "<cmd>tabc<cr>";
        description = "Close Diff View";
        key = "q";
        mode = "n";
      }
    ];
  };
}
