{
  pkgs,
  lib,
  config,
  ...
}:
let
  opencodeConfig = pkgs.writeText "opencode.json" (
    builtins.toJSON {
      "$schema" = "https://opencode.ai/config.json";
      model = "llama-server/qwen3.6-35b-a3b";
      permission = {
        "*" = "ask";
        glob = "allow";
        read = {
          "*" = "allow";
          "*.env" = "deny";
          "*.env.*" = "deny";
          "*.env.example" = "allow";
        };
        grep = "allow";
        webfetch = "allow";
      };
      provider = {
        "llama-server" = {
          npm = "@ai-sdk/openai-compatible";
          name = "llama.cpp (local)";
          options.baseURL = "http://127.0.0.1:11434/v1";
          models = {
            "qwen3.6-27b" = {
              name = "Qwen3.6-27B (local)";
              limit = {
                context = 131072;
                output = 8192;
              };
            };
            "qwen3.6-35b-a3b" = {
              name = "Qwen3.6-35B-A3B (local)";
              limit = {
                context = 131072;
                output = 16384;
              };
            };
          };
        };
      };
    }
  );
in
{
  config = lib.mkIf config.opt.features.devUtils.enable {
    home.file.".config/opencode/opencode.json" = {
      source = opencodeConfig;
      force = true;
    };
  };
}
