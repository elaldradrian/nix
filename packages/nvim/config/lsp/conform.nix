{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    prettierd
    shfmt
    stylua
    nixfmt-rfc-style
    google-java-format
    xmlformat
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
        css = [ "prettierd" ];
        graphql = [ "prettierd" ];
        handlebars = [ "prettierd" ];
        html = [ "prettierd" ];
        javascript = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
        json = [ "prettierd" ];
        jsonc = [ "prettierd" ];
        less = [ "prettierd" ];
        markdown = [ "prettierd" ];
        markdownd = [ "prettierd" ];
        scss = [ "prettierd" ];
        typescript = [
          "prettierd"
          "eslint_d"
        ];
        typescriptreact = [ "prettierd" ];
        vue = [ "prettierd" ];
        yaml = [ "prettierd" ];
        xml = [ "xmlformat" ];

        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        java = [ "google-java-format" ];
        groovy = [ "npm_groovy_lint" ];
        sh = [ "shfmt" ];
      };
    };
  };
}
