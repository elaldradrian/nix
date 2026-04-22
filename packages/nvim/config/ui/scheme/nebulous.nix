{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "78aa15cdece6700877cdcf464e45dd8b713e1bc1";
        hash = "sha256-p8TnOfE4+pKF6MCbMSQXs4QZuIIfb0gPMujFx4r/Foc=";
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
