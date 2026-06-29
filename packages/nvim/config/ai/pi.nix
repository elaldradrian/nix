{ pkgs, ... }:
let
  pi = pkgs.vimUtils.buildVimPlugin {
    pname = "pi.nvim";
    version = "unstable-2026-06-21";
    src = pkgs.fetchFromGitHub {
      owner = "alex35mil";
      repo = "pi.nvim";
      rev = "32f5db025dde539ca6b30d9510144eeebff5e10f";
      hash = "sha256-aJCwkp//xk6XdcKDJMowUXlt7AGM4xoLTlTCp6hdqfQ=";
    };
  };
in
{
  extraPlugins = [ pi ];

  plugins.img-clip.enable = true;

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<Leader>pp";
      action = "<cmd>Pi layout=side<cr>";
      options.desc = "Pi: side panel";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<Leader>pf";
      action = "<cmd>Pi layout=float<cr>";
      options.desc = "Pi: float window";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<Leader>pl";
      action = "<cmd>PiToggleLayout<cr>";
      options.desc = "Pi: toggle layout";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<Leader>pc";
      action = "<cmd>PiContinue<cr>";
      options.desc = "Pi: continue session";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<Leader>pr";
      action = "<cmd>PiResume<cr>";
      options.desc = "Pi: resume session";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<Leader>pm";
      action = "<cmd>PiSendMention<cr>";
      options.desc = "Pi: mention file/selection";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<Leader>pa";
      action = "<cmd>PiAttention<cr>";
      options.desc = "Pi: attention request";
    }
  ];

  autoGroups = {
    pi-keymaps = {
      clear = true;
    };
  };

  autoCmd =
    let
      mkPiAcmd = pattern: callback: {
        event = "FileType";
        group = "pi-keymaps";
        inherit pattern;
        callback.__raw = callback;
      };

      allPiPatterns = [
        "pi-chat-history"
        "pi-chat-prompt"
        "pi-chat-attachments"
      ];
    in
    [
      (mkPiAcmd allPiPatterns ''
        function(event)
          local function map(key, action, modes)
            vim.keymap.set(modes or { "n", "i", "v" }, key, action, { buffer = event.buf })
          end
          map("<C-q>", "<Cmd>PiToggleChat<CR>")
          map("<M-c>", "<Cmd>PiAbort<CR>")
          map("<C-o>", require("pi").toggle_history_blocks)
        end
      '')

      (mkPiAcmd [ "pi-chat-history" ] ''
        function(event)
          vim.keymap.set({ "n", "i", "v" }, "<M-j>", require("pi").focus_chat_prompt, { buffer = event.buf })
        end
      '')

      (mkPiAcmd [ "pi-chat-prompt" ] ''
        function(event)
          local pi = require("pi")
          local function map(key, action, modes)
            vim.keymap.set(modes or { "n", "i", "v" }, key, action, { buffer = event.buf })
          end
          map("<M-k>", pi.focus_chat_history)
          map("<M-j>", pi.focus_chat_attachments)
          map("<C-Up>",   function() pi.scroll_chat_history("up", 2) end)
          map("<C-Down>", function() pi.scroll_chat_history("down", 2) end)
          map("<M-m>", pi.cycle_model)
          map("<M-M>", pi.select_model)
          map("<M-t>", pi.cycle_thinking_level)
          map("<M-T>", pi.select_thinking_level)
          map("<M-n>", pi.new_session)
          map("<M-x>", pi.compact)
          map("<C-v>", pi.paste_image)
        end
      '')

      (mkPiAcmd [ "pi-chat-attachments" ] ''
        function(event)
          local pi = require("pi")
          vim.keymap.set({ "n", "i", "v" }, "<M-k>", pi.focus_chat_prompt, { buffer = event.buf })
          vim.keymap.set({ "n", "i", "v" }, "<C-v>", pi.paste_image, { buffer = event.buf })
        end
      '')
    ];

  extraConfigLua = # lua
    ''
      require("pi").setup({
        zen = {
          keys = {
            toggle = "<M-z>",
          },
        },
      })
    '';
}
