{
  plugins.noice = {
    enable = true;
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
    ];
  };
}
