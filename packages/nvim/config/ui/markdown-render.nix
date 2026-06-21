{
  plugins.render-markdown = {
    enable = true;
    lazyLoad.settings.ft = [
      "markdown"
      "opencode_output"
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
