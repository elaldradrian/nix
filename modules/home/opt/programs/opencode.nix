{
  lib,
  config,
  ...
}:
{
  options = { };

  config = lib.mkIf config.opt.features.devUtils.enable {
    sops.secrets = {
      opencode_remote_baseurl = { };
      opencode_remote_api_key = { };
    };

    sops.templates.opencode-config = {
      path = "${config.home.homeDirectory}/.config/opencode/opencode.json";
      content = builtins.toJSON {
        "$schema" = "https://opencode.ai/config.json";
        plugin = [ "@simonwjackson/opencode-direnv" ];
        model = "llama-server-remote/qwen3.6-27b";
        permission = {
          bash = {
            "*" = "ask";
          };
          edit = "allow";
          read = {
            "*" = "allow";
            "*.env" = "deny";
            "*.env.*" = "deny";
            "*.env.example" = "allow";
          };
          glob = "allow";
          grep = "allow";
          lsp = "allow";
          task = "allow";
          skill = "allow";
          question = "allow";
          webfetch = "allow";
          websearch = "allow";
          codesearch = "allow";
          external_directory = "ask";
          doom_loop = "ask";
        };
        provider = {
          "llama-server-local" = {
            npm = "@ai-sdk/openai-compatible";
            name = "llama.cpp (local)";
            options = {
              baseURL = "http://localhost:11434/v1";
            };
            models = {
              "qwen3.6-27b" = {
                name = "Qwen3.6-27B (local)";
                limit = {
                  context = 64000;
                  output = 16384;
                };
              };
              "qwen3.6-35b-a3b" = {
                name = "Qwen3.6-35B-A3B (local)";
                limit = {
                  context = 250000;
                  output = 16384;
                };
              };
            };
          };
          "llama-server-remote" = {
            npm = "@ai-sdk/openai-compatible";
            name = "llama.cpp (remote)";
            options = {
              baseURL = config.sops.placeholder.opencode_remote_baseurl;
              apiKey = "{file:${config.sops.secrets.opencode_remote_api_key.path}}";
            };
            models = {
              "qwen3.6-27b" = {
                name = "Qwen3.6-27B (remote)";
                limit = {
                  context = 190000;
                  output = 16384;
                };
              };
              "qwen3.6-35b-a3b" = {
                name = "Qwen3.6-35B-A3B (local)";
                limit = {
                  context = 250000;
                  output = 16384;
                };
              };
            };
          };
        };
      };
    };
  };
}
