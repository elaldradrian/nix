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
    ];
  };
}
