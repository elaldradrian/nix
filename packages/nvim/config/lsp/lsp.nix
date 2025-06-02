{
  self,
  pkgs,
  # system,
  ...
}:
let
  # nodePackages = import ../../../node2nix {
  #   inherit pkgs system;
  #   nodejs = pkgs.nodejs;
  # };
  bicepLsp = pkgs.stdenv.mkDerivation rec {
    pname = "bicep-langserver";
    version = "0.32.4";

    src = pkgs.fetchzip {
      url = "https://github.com/Azure/bicep/releases/download/v${version}/bicep-langserver.zip";
      sha256 = "sha256-/lzu9cUEwo/4v5mEwVrLEwbY1p69mrekjU0nxRY/+FQ=";
      stripRoot = false;
    };

    buildInputs = with pkgs; [
      which
      dotnet-sdk
    ];

    installPhase = # Bash
      ''
        mkdir -p $out/lib $out/bin
        cp -r * $out/lib/

        echo '#!/bin/sh' > $out/bin/bicep-langserver
        echo "exec $(which dotnet) $out/lib/Bicep.LangServer.dll \"\$@\"" >> $out/bin/bicep-langserver
        chmod +x $out/bin/bicep-langserver
      '';

    meta = with pkgs.lib; {
      description = "Bicep Language Server for LSP support";
      homepage = "https://github.com/Azure/bicep";
      license = licenses.mit;
    };
  };
in
{
  plugins = {
    helm.enable = true;
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        bicep = {
          enable = true;
          package = bicepLsp;
          cmd = [
            "${bicepLsp}/bin/bicep-langserver"
          ];
        };
        html.enable = true;
        lua_ls.enable = true;
        nixd = {
          enable = true;
          settings =
            let
              flake = ''(builtins.getFlake "${self}")'';
            in
            {
              nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
              options = {
                flake-parts.expr = "${flake}.debug.options";
                # darwin.expr = "${flake}.darwinConfigurations.rune-mac.options";
                # home-manager.expr = "${darwin.expr}.homeConfigurations.rune-mac.options";
              };
            };
        };
        jsonls.enable = true;
        jdtls.enable = true;
        helm_ls.enable = true;
        hls = {
          enable = true;
          installGhc = false;
        };
        yamlls.enable = true;
        ts_ls.enable = true;
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
          # "<leader>cr" = {
          #   action = "rename";
          #   desc = "Rename";
          # };
        };
      };
    };
  };
}
