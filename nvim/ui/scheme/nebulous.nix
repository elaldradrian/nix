{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "Yagua";
        repo = "nebulous.nvim";
        rev = "9599c2da4d234b78506ce30c6544595fac25e9ca";
        hash = "sha256-8th7rTla9mAXR5jUkYI3rz7xa9rWSSGHZqicheWYq50=";
      };
    })
  ];

  extraConfigLua = # Lua
    ''
        local colors = require("nebulous.functions").get_colors("twilight")
        colors.background = "#000000"
      require('nebulous').setup(
      {
          variant = "twilight",
          custom_colors = {
            Visual = { bg = colors.Custom_1 },
            NormalFloat = { bg = colors.background },
            Special = { style = "none" },
          },
        })
    '';
}
