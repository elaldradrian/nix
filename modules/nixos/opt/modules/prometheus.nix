{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.opt.features.prometheus.enable {
    sops.secrets."llama-cpp-api-key-prometheus" = {
      key = "llama-cpp-api-key";
      owner = "prometheus";
      group = "prometheus";
      mode = "0400";
      restartUnits = [ "prometheus.service" ];
    };

    services.prometheus = {
      enable = true;
      retentionTime = "30d";
      checkConfig = "syntax-only";

      globalConfig.scrape_interval = "15s";

      scrapeConfigs = [
        {
          job_name = "llama-cpp";
          metrics_path = "/metrics";
          params.autoload = [ "false" ];
          authorization = {
            type = "Bearer";
            credentials_file = config.sops.secrets."llama-cpp-api-key-prometheus".path;
          };
          static_configs = [
            {
              targets = [ "localhost:11434" ];
              labels.llama_model_id = "qwen3.6-27b";
            }
            {
              targets = [ "localhost:11434" ];
              labels.llama_model_id = "qwen3.6-35b-a3b";
            }
          ];
          relabel_configs = [
            {
              source_labels = [ "llama_model_id" ];
              target_label = "__param_model";
            }
            # Make instance unique per model so the targets page and
            # alerting rules can distinguish them.
            {
              source_labels = [
                "__address__"
                "llama_model_id"
              ];
              separator = "/";
              target_label = "instance";
            }
          ];
        }
      ];
    };
  };
}
