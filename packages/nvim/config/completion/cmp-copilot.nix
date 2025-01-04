{
  plugins.copilot-lua = {
    enable = true;
    suggestion = {
      enabled = true;
      autoTrigger = true;
      keymap.accept = "<S-CR>";
    };
    panel.enabled = false;
  };

  extraConfigLua = # Lua
    ''
      require("copilot").setup({
        auto_trigger = true,
        hide_during_completion = false,
        keymap = {
          accept = "<S-CR>",
        },
        panel = { enabled = false },
      })
    '';
}
