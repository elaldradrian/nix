{
  pkgs,
  lib,
  config,
  user,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;

  pr22673Src = pkgs.fetchFromGitHub {
    owner = "am17an";
    repo = "llama.cpp";
    rev = "e7b4848151377395b1693d326d1cda3fcd61c2d9";
    hash = "sha256-ScHAWQlFV5WSPgGONpX90CLXixejqzbT+bUqZHY3Zkg=";
  };

  llama-pkgs = (
    (pkgs.llama-cpp.override {
      vulkanSupport = true;
    }).overrideAttrs
      (prev: {
        version = "22673";
        src = pr22673Src;
        npmDeps = pkgs.fetchNpmDeps {
          name = "llama-cpp-22673-npm-deps";
          inherit (prev) patches;
          src = pr22673Src;
          preBuild = "pushd tools/server/webui";
          hash = "sha256-cV3noOyKmst9vfxyvkCNhihPgwfVGhmPPT4UMloeWZM=";
        };
      })
  );

  llama-server = "${llama-pkgs}/bin/llama-server";

  modelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { } {
      "qwen3.6-27b" = {
        model = "/Users/${user}/models/Qwen3.6-27B-MTP-UD-Q5_K_XL.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "20";
        checkpoint-every-n-tokens = "6144";
        cache-ram = "4000";
        ctx-size = "100000";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        ngl = 99;
        fit = "off";
        keep = "-1";
        min-p = "0.00";
        no-mmap = "true";
        parallel = "1";
        presence-penalty = "0";
        repeat-penalty = "1";
        temp = "0.6";
        top-k = "20";
        top-p = "0.95";
        batch-size = "2048";
        ubatch-size = "512";
        spec-type = "mtp";
        spec-draft-n-max = "2";
        no-mmproj-offload = "true";
      };
      "qwen3.6-35b-a3b" = {
        model = "/Users/${user}/models/Qwen3.6-35B-A3B-UD-Q5_K_XL.gguf";
        jinja = "true";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "20";
        checkpoint-every-n-tokens = "6144";
        cache-ram = "4000";
        fit = "off";
        ngl = 99;
        keep = "-1";
        min-p = "0.00";
        no-mmap = "true";
        parallel = "1";
        presence-penalty = "0";
        repeat-penalty = "1";
        temp = "0.6";
        top-k = "20";
        top-p = "0.95";
        batch-size = "4096";
        ubatch-size = "2048";
        spec-type = "ngram-mod";
        no-mmproj-offload = "true";
      };
    }
  );
in
{
  config = lib.mkIf (config.opt.features.llama-cpp.enable) {
    home.packages = [ pkgs.llama-cpp ];

    # macOS
    launchd.agents.llama-cpp = lib.mkIf isDarwin {
      enable = true;
      config = {
        ProgramArguments = [
          "${llama-server}"
          "--host"
          "0.0.0.0"
          "--port"
          "11434"
          "--models-preset"
          "${modelsIni}"
        ];
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/llama-cpp.log";
        StandardErrorPath = "/tmp/llama-cpp.err.log";
      };
    };
  };
}
