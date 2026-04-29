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
        rev = "1db841b8e9d4dd75f9899b97efb98fc18fb730cd";
        hash = "sha256-S3qJE5nzaJaItQ9GhnMAnyQClwdvsUa3syygKNqzaHk=";
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
