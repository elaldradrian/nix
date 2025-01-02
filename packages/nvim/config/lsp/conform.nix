{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    prettierd
    eslint_d
    shfmt
    stylua
    nixfmt-rfc-style
    google-java-format
    libxml2
  ];

  plugins.conform-nvim = {
    enable = true;
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
        html = [ "prettierd" ];
        java = [ "google-java-format" ];
        javascript = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
        json = [ "prettierd" ];
        jsonc = [ "prettierd" ];
        less = [ "prettierd" ];
        lua = [ "stylua" ];
        markdown = [ "prettierd" ];
        markdownd = [ "prettierd" ];
        nix = [ "nixfmt" ];
        scss = [ "prettierd" ];
        sh = [ "shfmt" ];
        typescript = [
          "prettierd"
          "eslint_d"
        ];
        typescriptreact = [ "prettierd" ];
        vue = [ "prettierd" ];
        xml = [ "xmllint" ];
        yaml = [ "prettierd" ];
      };
    };
  };
}
