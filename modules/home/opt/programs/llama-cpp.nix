{
  pkgs,
  lib,
  config,
  user,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;

  llama-pkgs =
    let
      newSrc = pkgs.llama-cpp.src.override {
        tag = "b9789";
        hash = "sha256-G6e50Vf1lh68R87hE8dTeqmyVHTiMywG0hYHSbGlbWo=";
      };
    in
    pkgs.llama-cpp.overrideAttrs (prev: {
      version = "9789";
      npmRoot = "tools/ui";
      src = newSrc;
      npmDeps = pkgs.fetchNpmDeps {
        name = "llama-cpp-9789-npm-deps";
        inherit (prev) patches;
        src = newSrc;
        preBuild = ''
          pushd tools/ui
        '';
        hash = "sha256-X1DZgmhS/zHTqDT5zq0kywwntthcJ9vRXeqyO3zz6UU=";
      };
    });

  llama-server = "${llama-pkgs}/bin/llama-server";

  modelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { } {
      "qwen3.6-27b" = {
        model = "/Users/${user}/models/Qwen3.6-27B-UD-Q4_K_XL.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        cache-ram = "4000";
        ctx-size = "64000";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        kv-unified = "true";
        no-mmap = "true";
        mlock = true;
        parallel = "1";
        presence-penalty = "0";
        repeat-penalty = "1";
        temp = "0.6";
        min-p = "0.00";
        top-k = "20";
        top-p = "0.95";
        batch-size = "2048";
        ubatch-size = "512";
        spec-type = "draft-mtp";
        spec-draft-n-max = "2";
        no-mmproj-offload = "true";
      };
      "qwen3.6-35b-a3b" = {
        model = "/Users/${user}/models/Qwen3.6-35B-A3B-UD-Q3_K_XL.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        cache-ram = "4000";
        ctx-size = "64000";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        kv-unified = "true";
        no-mmap = "true";
        mlock = true;
        parallel = "1";
        presence-penalty = "0";
        repeat-penalty = "1";
        temp = "0.6";
        min-p = "0.00";
        top-k = "20";
        top-p = "0.95";
        batch-size = "2048";
        ubatch-size = "512";
        spec-type = "draft-mtp";
        spec-draft-n-max = "2";
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
          "--models-max"
          "1"
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
