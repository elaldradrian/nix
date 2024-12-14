{
  autoCmd = [
    {
      desc = "Check if we need to reload the file when it changed";
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      callback.__raw = # lua
        ''
          function()
              if vim.o.buftype ~= "nofile" then
                vim.cmd("checktime")
              end
            end
        '';
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
