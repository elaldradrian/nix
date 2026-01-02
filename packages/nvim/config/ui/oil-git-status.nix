{
  plugins.oil-git-status = {
    enable = true;
    lazyLoad.settings = {
      event = "DeferredUIEnter";
      before.__raw = ''
        function()
          require('lz.n').trigger_load('oil.nvim')
        end
      '';
    };
    settings = {
      show_ignored = false;
    };
  };
}
