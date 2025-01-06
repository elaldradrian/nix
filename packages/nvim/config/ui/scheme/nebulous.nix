{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "cbc861435890cdc2961031a501187ac94e537fed";
        hash = "sha256-um9G0BQbj+/SCoPpKz1J+kkhz2dCzKhMaY5tT0U/IrY=";
      };
    })
  ];

  extraConfigLua = # Lua
    ''
      require('nebulous').setup({
        variant = "twilight",
      })
    '';
}
