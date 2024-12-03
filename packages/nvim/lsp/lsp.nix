{
  pkgs,
  system,
  ...
}:
let
  nodePackages = import ../../node2nix {
    inherit pkgs system;
    nodejs = pkgs.nodejs;
  };
in
{
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        bicep = {
          enable = true;
          package = pkgs.bicep;
          cmd = [ "${pkgs.bicep}/bin/bicep" ];
        };
        html.enable = true;
        lua_ls.enable = true;
        # TODO: use instead of nil_ls
        # nixd = {
        #   enable = true;
        #   extraOptions = {
        #     offset_encoding = "utf-8";
        #   };
        # };
        nil_ls.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        vtsls = {
          enable = true;
          package = nodePackages."@vtsls/language-server";
        };
        eslint.enable = true;
        sqls.enable = true;
        kotlin_language_server.enable = true;
        gradle_ls = {
          enable = true;
          package = pkgs.vscode-extensions.vscjava.vscode-gradle;
          cmd = [
            "java"
            "-jar"
            "${pkgs.vscode-extensions.vscjava.vscode-gradle}/share/vscode/extensions/vscjava.vscode-gradle/lib/gradle-language-server.jar"
          ];
          settings = {
            init_options = {
              settings = {
                gradleWrapperEnabled = true;
              };
            };
          };
        };
      };
      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          # Use LSP saga keybinding instead
          # K = {
          #   action = "hover";
          #   desc = "Hover";
          # };
          # "<leader>cw" = {
          #   action = "workspace_symbol";
          #   desc = "Workspace Symbol";
          # };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        # diagnostic = {
        #   "<leader>cd" = {
        #     action = "open_float";
        #     desc = "Line Diagnostics";
        #   };
        #   "[d" = {
        #     action = "goto_next";
        #     desc = "Next Diagnostic";
        #   };
        #   "]d" = {
        #     action = "goto_prev";
        #     desc = "Previous Diagnostic";
        #   };
        # };
      };
    };
  };
  # extraConfigLua = # Lua
  #   ''
  #     local _border = "rounded"
  #
  #     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  #       vim.lsp.handlers.hover, {
  #         border = _border
  #       }
  #     )
  #
  #     vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  #       vim.lsp.handlers.signature_help, {
  #         border = _border
  #       }
  #     )
  #
  #     vim.diagnostic.config{
  #       float={border=_border}
  #     };
  #
  #     require('lspconfig.ui.windows').default_options = {
  #       border = _border
  #     }
  #   '';
}
