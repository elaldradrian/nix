{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "3e67f6df4e01c3efe8991e7878f3ffe2f6e4650b";
        hash = "sha256-eqlO7mPaceUAZks9UpWpK6Jx+AnElYuIVSW6UwmNxkc=";
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
