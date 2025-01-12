{
  plugins.copilot-lua = {
    enable = true;
    settings = {
      suggestion = {
        enabled = true;
        auto_trigger = true;
        hide_during_completion = false;
        keymap.accept = "<S-CR>";
      };
      panel.enabled = false;
    };
  };
}
