{
  plugins.noice = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";
    settings.routes = [
      {
        filter = {
          event = "msg_show";
          kind = "";
          find = "written";
        };
        view = "mini";
      }
      {
        filter = {
          event = "lsp";
          kind = "progress";
          find = "Processing";
        };
        skip = true;
      }
      # Ignore message with % line no. of file
      {
        filter = {
          event = "msg_show";
          kind = "";
          find = "%-%-%d+%%%-%-";
        };
        skip = true;
      }
    ];
  };
}
