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
        "codecompanion"
      ];
      code = {
        border = "thick";
      };
    };
  };
}
