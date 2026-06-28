{
  plugins.render-markdown = {
    enable = true;
    lazyLoad.settings.ft = [
      "markdown"
      "opencode_output"
      "pi-chat-history"
    ];
    settings = {
      file_types = [
        "markdown"
        "opencode_output"
        "pi-chat-history"
      ];
      code = {
        border = "thick";
      };
    };
  };
}
