{
  autoCmd = [
    {
      desc = "Highlight on yank";
      event = "TextYankPost";
      callback.__raw = # lua
        ''
          function() vim.highlight.on_yank({ higroup="IncSearch", timeout=250 }) end
        '';
    }
    #   event = [
    #     "BufLeave"
    #   ];
    #   callback = {
    #     __raw = # Lua
    #       ''
    #         function()
    #           if vim.bo.modified then
    #             require("conform").format()
    #             vim.cmd("write")
    #           end
    #         end
    #       '';
    #   };
    # }
  ];
}
