{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "82c9253c17286ed9275cd48fb8ca2f687e3ee7f2";
        hash = "sha256-D3HFFAs3UEAFAewpB8F+G7Y8K36AU6cI+WylXqXWsvA=";
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
