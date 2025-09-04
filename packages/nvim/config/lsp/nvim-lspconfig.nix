{
  pkgs,
  ...
}:
let
  bicepLsp = pkgs.stdenv.mkDerivation rec {
    pname = "bicep-langserver";
    version = "0.37.4";

    src = pkgs.fetchzip {
      url = "https://github.com/Azure/bicep/releases/download/v${version}/bicep-langserver.zip";
      sha256 = "sha256-Eo/t3tnOOVUwdAQZBEcsaH36CNXt7InFqNYpmrAQZK8=";
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
      inlayHints = false;
      servers = {
        bicep = {
          enable = true;
          package = bicepLsp;
          cmd = [ "${bicepLsp}/bin/bicep-langserver" ];
        };
        eslint.enable = true;
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
        helm_ls.enable = true;
        hls = {
          enable = true;
          installGhc = false;
        };
        html.enable = true;
        jdtls.enable = true;
        jsonls.enable = true;
        kotlin_language_server.enable = true;
        # kulala_ls.enable = true;
        lua_ls.enable = true;
        nixd.enable = true;
        sqls.enable = true;
        ts_ls.enable = true;
        yamlls.enable = true;
      };
    };
  };
}
