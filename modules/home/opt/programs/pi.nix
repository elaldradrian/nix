{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.opt.features.devUtils.enable {
    home.file.".pi/agent/settings.json".text = builtins.toJSON {
      defaultProvider = "llama-cpp-remote";
      defaultModel = "qwen3.6-35b-a3b";
    };

    sops.templates.pi-models = {
      path = "${config.home.homeDirectory}/.pi/agent/models.json";
      content = builtins.toJSON {
        providers = {
          llama-cpp = {
            baseUrl = "http://localhost:11434/v1";
            api = "openai-completions";
            apiKey = "none";
            models = [
              {
                id = "qwen3.6-27b";
                name = "Qwen3.6-27B (Local)";
                contextWindow = 190000;
                maxTokens = 16384;
              }
              {
                id = "qwen3.6-35b-a3b";
                name = "Qwen3.6-35B-A3B (Local)";
                contextWindow = 250000;
                maxTokens = 16384;
              }
            ];
          };
          "llama-cpp-remote" = {
            baseUrl = config.sops.placeholder.opencode_remote_baseurl;
            api = "openai-completions";
            apiKey = config.sops.placeholder.opencode_remote_api_key;
            models = [
              {
                id = "qwen3.6-27b";
                name = "Qwen3.6-27B (Remote)";
                contextWindow = 190000;
                maxTokens = 16384;
              }
              {
                id = "qwen3.6-35b-a3b";
                name = "Qwen3.6-35B-A3B (Remote)";
                contextWindow = 250000;
                maxTokens = 16384;
              }
            ];
          };
        };
      };
    };
  };
}
