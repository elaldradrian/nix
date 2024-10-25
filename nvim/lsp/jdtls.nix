{ lib, pkgs, ... }:
{
  extraConfigLuaPre = # Lua
    ''
      local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
    '';

  plugins.nvim-jdtls = {
    enable = true;
    cmd = ""; # Bypass assert
    rootDir.__raw = # Lua
      ''
        root_dir
      '';
    extraOptions = {
      cmd.__raw = # Lua
        ''
          {
          "${lib.getExe pkgs.jdt-language-server}",
          string.format("--jvm-arg=-javaagent:%s", ${lib.getExe pkgs.lombok}),
           "-configuration",
          vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root_dir, ':t') .. "/config",
          "-data",
          vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root_dir, ':t') .. "/workspace",
          } 
        '';
    };
  };
}
