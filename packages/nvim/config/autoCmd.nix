{
  autoCmd = [
    {
      desc = "Check if we need to reload the file when it changed";
      event = [
        "BufEnter"
        "CursorHold"
        "CursorHoldI"
        "FocusGained"
      ];
      pattern = "*";
      command = "if mode() != 'c' | checktime | endif";
    }
    {
      desc = "Highlight on yank";
      event = "TextYankPost";
      callback.__raw = # lua
        ''
          function() 
            vim.highlight.on_yank({ higroup="IncSearch", timeout=250 })
          end
        '';
    }
    {
      event = "FileType";
      pattern = "helm";
      command = "LspRestart";
    }
  ];
}
