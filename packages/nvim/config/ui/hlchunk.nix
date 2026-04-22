{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "hlchunk";
      src = pkgs.fetchFromGitHub {
        owner = "shellRaining";
        repo = "hlchunk.nvim";
        rev = "3bc2bd7aef28fbed6643534a0fdd0f19966544bc";
        hash = "sha256-3B9j0O6sUXeOXxYmDlJb/nywHq6Q2kmbG3LkfLEaQt8=";
      };
    })
  ];

  extraConfigLua = # Lua
    ''
      require("lz.n").load {
          {
              "hlchunk.nvim",
              event = "BufReadPost";
              after = function()
                local colors = require("nebulous.functions").get_colors("twilight")

                require("hlchunk").setup({
                  chunk = {
                    enable = true,
                    style =
                      {
                        { fg = colors.Cyan },
                        { fg = colors.Red },
                      }
                  },
                  indent = {
                    enable = true,
                  },
                  line_num = {
                    enable = true,
                    style = colors.Cyan,
                    use_treesitter = true
                  }
                })
              end,
          },
      }
    '';
}
