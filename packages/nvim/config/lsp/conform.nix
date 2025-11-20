{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    prettierd
    shfmt
    stylua
    nixfmt-rfc-style
    google-java-format
    libxml2
    markdownlint-cli2
  ];

  plugins.conform-nvim = {
    enable = true;
    lazyLoad.settings.event = "BufWritePre";
    settings = {
      format_after_save = {
        lspFallback = true;
        async = true;
      };

      notify_on_error = true;

      formatters = {
        npm_groovy_lint = {
          command = "npm-groovy-lint";
          stdin = false;
          args = [
            # "--rulesets"
            # "'Indentation{\"spacesPerIndentLevel\":2,\"severity\":\"warning\"}'"
            # "--rulesetsoverridetype"
            # "appendConfig"
            "--fix"
            "--nolintafter"
            "--failon"
            "none"
            "$FILENAME"
          ];
        };
      };
      formatters_by_ft = {
        "_" = [ "trim_whitespace" ];
        bicep = {
          lsp_format = "prefer";
        };
        css = [ "prettierd" ];
        graphql = [ "prettierd" ];
        groovy = [ "npm_groovy_lint" ];
        handlebars = [ "prettierd" ];
        haskell = {
          lsp_format = "prefer";
        };
        html = [ "prettierd" ];
        java = [ "google-java-format" ];
        javascript = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
        json = [ "prettierd" ];
        jsonc = [ "prettierd" ];
        less = [ "prettierd" ];
        lua = [ "stylua" ];
        markdown = [
          "prettierd"
          "markdownlint-cli2"
        ];
        markdownd = [
          "prettierd"
          "markdownlint-cli2"
        ];
        nix = [ "nixfmt" ];
        scss = [ "prettierd" ];
        sh = [ "shfmt" ];
        typescript = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
        vue = [ "prettierd" ];
        xml = [ "xmllint" ];
        yaml = [ "prettierd" ];
      };
    };
  };
}
