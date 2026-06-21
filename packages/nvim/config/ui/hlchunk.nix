{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "hlchunk";
      src = pkgs.fetchFromGitHub {
        owner = "shellRaining";
        repo = "hlchunk.nvim";
        rev = "06f51922ca43d5cdacf96725c106405fe064c59e";
        hash = "sha256-ETsuiYjTR4JF/4RVqRXJHLtcoalEaFinHxxD4Ww34xU=";
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
