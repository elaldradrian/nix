{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.opt.features.devUtils.enable {
    home.file.".pi/agent/settings.json".text = builtins.toJSON {
      defaultProvider = "llama-cpp";
      defaultModel = "qwen3.6-35b-a3b";
    };

    home.file.".pi/agent/models.json".text = builtins.toJSON {
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
      };
    };
  };
}
