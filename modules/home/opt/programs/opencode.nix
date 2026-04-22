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
      permission."*" = "ask";
      provider = {
        "llama-server" = {
          npm = "@ai-sdk/openai-compatible";
          name = "llama.cpp (local)";
          options.baseURL = "http://10.17.16.121:11434/v1";
          models = {
            "qwen3.5-9b" = {
              name = "Qwen3.5-9B (local)";
              limit = {
                context = 10000;
                output = 8192;
              };
            };
            "qwen3.6-27b" = {
              name = "Qwen3.6-27B (local)";
              limit = {
                context = 5000;
                output = 8192;
              };
            };
            "qwen3.6-35b-a3b" = {
              name = "Qwen3.6-35B-A3B (local)";
              limit = {
                context = 65536;
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
