{
  plugins.which-key = {
    enable = true;
    settings.spec = [
      {
        __unkeyed-1 = "<leader>b";
        group = "Buffers";
      }
      {
        __unkeyed-1 = "<leader>w";
        group = "+windows";
        proxy = "<C-w>";
      }

      {
        __unkeyed = "<leader>f";
        group = "+file/file";
        mode = "n";
      }
      {
        __unkeyed = "<leader>h";
        group = "+http";
        mode = "n";
      }
      {
        __unkeyed = "<leader>s";
        group = "+search";
        mode = "n";
      }
      {
        __unkeyed = "<leader>g";
        group = "+git";
        mode = [
          "n"
          "v"
        ];
      }
      {
        __unkeyed = "<leader>u";
        group = "+ui";
        mode = "n";
      }
      {
        __unkeyed = "<leader>c";
        group = "+code";
        mode = [
          "n"
          "v"
        ];
      }
    ];
  };
}
