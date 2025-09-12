{ lib, pkgs, ... }:
{
  plugins.dap = {
    enable = true;
    adapters.servers.pwa-node = {
      host = "localhost";
      port = "\${port}";
      executable = {
        command = lib.getExe pkgs.vscode-js-debug;
        args = [
          "\${port}"
        ];
      };
    };
    configurations =
      let
        javascript-config = [
          {
            type = "pwa-node";
            request = "launch";
            name = "Launch file";
            program = "\${file}";
            cwd = "\${workspaceFolder}";
          }
          {
            type = "pwa-node";
            request = "launch";
            name = "Launch ts file";
            runtimeExecutable = "${lib.getExe pkgs.tsx}";
            program = "\${file}";
            cwd = "\${workspaceFolder}";
          }
          {
            type = "pwa-node";
            request = "attach";
            name = "Attach";
            processId.__raw = ''require ("dap.utils").pick_process'';
            cwd = "\${workspaceFolder}";
          }
          {
            type = "pwa-node";
            request = "attach";
            name = "Auto Attach";
            cwd.__raw = "vim.fn.getcwd()";
            protocol = "inspector";
            sourceMaps = true;
            resolveSourceMapLocations = [
              "\${workspaceFolder}/**"
              "!**/node_modules/**"
            ];
            restart = true;
          }
        ];
      in
      {
        javascript = javascript-config;
        typescript = javascript-config;
      };
  };
  plugins.dap-view.enable = true;
}
