{ lib, pkgs, ... }:
{
  extraConfigLuaPre = # Lua
    ''
      local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
    '';

  plugins.jdtls = {
    enable = true;
    settings = {
      cmd = [
        {
          __raw = "'${lib.getExe pkgs.jdt-language-server}'";
        }
        {
          __raw = "string.format('--jvm-arg=-javaagent:%s', '${pkgs.lombok}/share/java/lombok.jar')";
        }
        {
          __raw = "'-configuration ' .. vim.fn.stdpath('cache') .. '/jdtls/' .. vim.fn.fnamemodify(root_dir, ':t') .. '/config'";
        }
        {
          __raw = "'-data ' .. vim.fn.stdpath('cache') .. '/jdtls/' .. vim.fn.fnamemodify(root_dir, ':t') .. '/workspace')";
        }
      ];
      root_dir = {
        __raw = "root_dir";
      };
    };
  };
}
