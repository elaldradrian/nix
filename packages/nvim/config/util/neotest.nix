{ pkgs, ... }:
{
  plugins.neotest = {
    enable = true;
    package = pkgs.vimPlugins.neotest.overrideAttrs (_: {
      src = pkgs.fetchFromGitHub {
        owner = "nvim-neotest";
        repo = "neotest";
        rev = "52fca6717ef972113ddd6ca223e30ad0abb2800c";
        hash = "sha256-7CZ1BN9sxOQsn+6wPfdboMTYXeOf7Z98HjhQeqVMo0U=";
      };
      version = "git-52fca67"; # optional, cosmetic
    });
    settings = {
      status.virtual_text = true;
      discovery.filter_dir.__raw = # Lua
        ''
          function(name, rel_path, root)
            return name ~= "node_modules"
          end
        '';
    };
    adapters = {
      jest = {
        enable = true;
        settings = {
          jest_test_discovery = true;
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>tw";
      action.__raw = # Lua
        ''
          function()
            local neotest = require("neotest")
            local nio = require("nio")

            local file = vim.fn.expand("%:p"):gsub(".spec.ts$", ".ts"):gsub(".ts$", ".spec.ts")

            neotest.run.run({
              file,
              jestCommand = jestCommand() .. " --watch",
            })

            neotest.summary.open()

            nio.run(function()
              nio.sleep(1000)
              neotest.summary:expand(file, true)
            end)
          end
        '';
      options = {
        desc = "Watch File";
      };
    }
    {
      mode = "n";
      key = "<leader>tt";
      action.__raw = # Lua
        ''
          function()
            local neotest = require("neotest")
            local nio = require("nio")

            local file = vim.fn.expand("%:p"):gsub(".spec.ts$", ".ts"):gsub(".ts$", ".spec.ts")

            neotest.run.run(file)
            neotest.summary.open()

            nio.run(function()
              nio.sleep(1000)
              neotest.summary:expand(file, true)
            end)
          end
        '';
      options = {
        desc = "Run File";
      };
    }
    {
      mode = "n";
      key = "<leader>tn";
      action.__raw = # Lua
        ''
          function()
            local neotest = require("neotest")
            local nio = require("nio")

            neotest.run.run()
            neotest.summary.open()

            nio.run(function()
              nio.sleep(1000)
              neotest.summary:expand(file, true)
            end)
          end
        '';
      options = {
        desc = "Run File";
      };
    }
    {
      mode = "n";
      key = "<leader>td";
      action.__raw = # Lua
        ''
          function()
            local neotest = require("neotest")

            local file = vim.fn.expand("%:p"):gsub(".spec.ts$", ".ts"):gsub(".ts$", ".spec.ts")

            neotest.run.run({ file, strategy = "dap" })
          end
        '';
      options = {
        desc = "Debug File";
      };
    }
    {
      mode = "n";
      key = "<leader>tq";
      action.__raw = # Lua
        ''
          function()
            require("neotest").run.stop()
          end
        '';
      options = {
        desc = "Stop";
      };
    }
    {
      mode = "n";
      key = "<leader>ts";
      action.__raw = # Lua
        ''
          function()
            require("neotest").summary.toggle()
          end
        '';
      options = {
        desc = "Toggle Summary";
      };
    }
    {
      mode = "n";
      key = "<leader>to";
      action.__raw = # Lua
        ''
          function()
            require("neotest").output.open({ enter = true, auto_close = true })
          end
        '';
      options = {
        desc = "Show Output";
      };
    }
    {
      mode = "n";
      key = "<leader>tO";
      action.__raw = # Lua
        ''
          function()
            require("neotest").output_panel.toggle()
          end
        '';
      options = {
        desc = "Toggle Output Panel";
      };
    }
  ];
}
