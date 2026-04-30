{
  plugins.render-markdown = {
    enable = true;
    lazyLoad.settings.ft = [
      "markdown"
      "codecompanion"
    ];
    settings = {
      file_types = [
        "markdown"
        "opencode_output"
      ];
      code = {
        border = "thick";
      };
    };
  };
}
