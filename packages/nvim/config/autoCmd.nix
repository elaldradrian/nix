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
      desc = "Enable inline completion for LSP";
      event = "LspAttach";
      callback.__raw = # lua
        ''
          function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client:supports_method("textDocument/inlineCompletion") then
              vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
              vim.keymap.set(
                'i',
                '<S-CR>',
                vim.lsp.inline_completion.get,
                { desc = 'LSP: accept inline completion', buffer = bufnr }
              )
              vim.keymap.set(
                'i',
                '<C-G>',
                vim.lsp.inline_completion.select,
                { desc = 'LSP: switch inline completion', buffer = bufnr }
              )
            end
          end
        '';
    }
  ];
}
