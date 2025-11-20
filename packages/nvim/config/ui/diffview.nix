{
  plugins.diffview = {
    enable = true;
    lazyLoad.settings.cmd = [
      "DiffviewOpen"
      "DiffviewFileHistory"
      "DiffviewClose"
      "DiffviewToggleFiles"
      "DiffviewFocusFiles"
      "DiffviewRefresh"
    ];
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
