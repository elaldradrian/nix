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
        rev = "604eb62ed26dca112982adfbb511244807216245";
        hash = "sha256-d6OpGv7ZpUzmw87hOq9g2eSt9Svxv1//jfP2WAo4AvQ=";
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
        ui = {
          window_width = 0.50,
        },
        keymap = {
          input_window = {
            ["<esc>"] = false,
          },
          output_window = {
            ["<esc>"] = false,
          },
        },
        context = {
          selection = {
            enabled = false,
          },
          current_file = {
            enabled = false,
          },
          diagnostics = {
            info = false,
            warning = false,
            error = false,
          },
        },
      })
    '';
}
