{ lib, pkgs, ... }:
{
  extraConfigLuaPre = # Lua
    ''
      local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
    '';

  plugins.nvim-jdtls = {
    enable = true;
    cmd = [ ]; # Bypass assert
    rootDir.__raw = # Lua
      ''
        root_dir
      '';
    extraOptions = {
      cmd.__raw = # Lua
        ''
          {
            "${lib.getExe pkgs.jdt-language-server}",
            string.format("--jvm-arg=-javaagent:%s", "${pkgs.lombok}/share/java/lombok.jar"),
             "-configuration",
            vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root_dir, ':t') .. "/config",
            "-data",
            vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root_dir, ':t') .. "/workspace",
          } 
        '';
      handlers.__raw = # Lua
        ''
          {
            ["$/progress"] = function(_, _result, _ctx)
              -- disable progress updates.
            end,
          }
        '';
    };
  };
}
