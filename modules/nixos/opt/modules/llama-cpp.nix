{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.opt.features.llama-cpp.enable {
    services.llama-cpp = {
      enable = true;
      model = "/home/${user}/.llama-cpp/models/Qwen3.5-9B-Q4_K_M.gguf";
      extraFlags = [
        "--jinja"
        "-c"
        "8192"
        "-t"
        "16"
      ];
      host = "127.0.0.1";
      port = 11434;
    };
  };
}
