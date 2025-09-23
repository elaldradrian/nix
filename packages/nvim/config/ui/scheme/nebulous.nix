{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "1978258880da19c7def779aec83d56717f36f4e1";
        hash = "sha256-TWqUTHInvp0hfvgOMgtoVbWbneSaE7toS0oPwdg3Sbw=";
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
