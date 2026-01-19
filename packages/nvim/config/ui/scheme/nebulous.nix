{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "5450efb19b9abb9fe8848e7cb65ac99ba6815003";
        hash = "sha256-uPsfXgUmpZ+euATDPnKgOF9US4SVTnriC8+rKiLboj4=";
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
