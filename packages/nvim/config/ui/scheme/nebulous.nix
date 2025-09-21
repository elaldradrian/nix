{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "4919a7e9f66dbcc71827991cc54d0f6e14fe62c8";
        hash = "sha256-tQDkbHES6ZmIJvctEHJnp8eEqlKJLRzWOgeOY+Kfttg=";
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
