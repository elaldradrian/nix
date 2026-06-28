{ pkgs, ... }:
let
  pi = pkgs.vimUtils.buildVimPlugin {
    pname = "pi.nvim";
    version = "unstable-2026-06-21";
    src = pkgs.fetchFromGitHub {
      owner = "alex35mil";
      repo = "pi.nvim";
      rev = "32f5db025dde539ca6b30d9510144eeebff5e10f";
      hash = "sha256-aJCwkp//xk6XdcKDJMowUXlt7AGM4xoLTlTCp6hdqfQ=";
    };
  };
in
{
  extraPlugins = [ pi ];

  plugins.img-clip.enable = true;

  extraConfigLua = # Lua
    ''
      require("pi").setup({
        layout = {
          default = "side",
          side = {
            position = "right",
            width = 0.50,
          },
        },
        zen = {
          keys = {
            toggle = "<M-z>",
          },
        },
      })
    '';
}
