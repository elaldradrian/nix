{ pkgs, ... }:
let
  plenary =
    (pkgs.vimUtils.buildVimPlugin {
      pname = "plenary.nvim";
      version = "unstable-2026-04-10";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-lua";
        repo = "plenary.nvim";
        rev = "74b06c6c75e4eeb3108ec01852001636d85a932b";
        hash = "sha256-nkfETDkPiE+Kd2BWYZijgUp9bP8RgFwRmvqJz2BMuq4=";
      };
    }).overrideAttrs
      (_: {
        doCheck = false;
      });
  opencode =
    (pkgs.vimUtils.buildVimPlugin {
      pname = "opencode.nvim";
      version = "unstable-2026-04-24";
      src = pkgs.fetchFromGitHub {
        owner = "sudo-tee";
        repo = "opencode.nvim";
        rev = "3798e7f594c04112fb4ea6f9754520b959c5ed2e";
        hash = "sha256-5ydT+QoDmZrHbdX3l3KNflS+LqB2/c2xoZBEWPmEj6s=";
      };
    }).overrideAttrs
      (_: {
        doCheck = false;
      });
in
{
  extraPlugins = [
    plenary
    opencode
  ];

  extraConfigLua = # Lua
    ''
      require("opencode").setup({
        keymap = {
          input_window = {
            ["<esc>"] = false,
          },
          output_window = {
            ["<esc>"] = false,
          },
        },
      })
    '';
}
