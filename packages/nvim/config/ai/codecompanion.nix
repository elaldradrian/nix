{
  plugins.codecompanion = {
    enable = true;
    settings = {
      mcp = {
        servers = {
          vectorcode = {
            cmd = [ "vectorcode-mcp-server" ];
          };
          "effect-docs" = {
            cmd = [
              "docker"
              "run"
              "-i"
              "--rm"
              "timsmart/effect-mcp"
            ];
          };
          "open-websearch" = {
            cmd = [
              "docker"
              "run"
              "-i"
              "--rm"
              "-e"
              "MODE=stdio"
              "-e"
              "DEFAULT_SEARCH_ENGINE=duckduckgo"
              "ghcr.io/aas-ee/open-web-search:latest"
            ];
          };
        };
      };
      interactions = {
        chat = {
          adapter = "llama";
          keymaps = {
            codeblock = false;
            regenerate.modes.n = "g.";
            change_adapter.modes.n = "g?";
          };
          tools = {
            "web_search" = {
              enabled.__raw = "function() return false end";
            };
            "read_file" = {
              opts.require_approval_before = false;
            };
            "grep_search" = {
              opts.require_approval_before = false;
            };
            "memory" = {
              opts.require_approval_before = false;
            };
            groups.agent.tools = [
              "ask_questions"
              "create_file"
              "delete_file"
              "file_search"
              "get_changed_files"
              "get_diagnostics"
              "grep_search"
              "insert_edit_into_file"
              "read_file"
              "run_command"
            ];
          };
        };
        inline.adapter = "llama";
        agent.adapter = "llama";
        shared.keymaps = {
          always_accept.modes.n = "g+";
          accept_change.modes.n = "ga";
          reject_change.modes.n = "gr";
          cancel.modes.n = "gc";
        };
      };
      adapters = {
        http = {
          llama = {
            __raw = ''
              function()
                return require('codecompanion.adapters').extend('openai_compatible', {
                  env = {
                    url = "http://127.0.0.1:11434",
                  },
                  schema = {
                    model = {
                      default = 'qwen3.6-35b-a3b';
                      choices = {
                        "qwen3.6-27b",
                        "qwen3.6-35b-a3b",
                        "gemma-4-26b-a4b",
                        "gemma-4-31b",
                      },
                    },
                  },
                  handlers = {
                    form_messages = function(self, messages)
                      local system_content = {}
                      local other_messages = {}
                      for _, msg in ipairs(messages) do
                        if msg.role == "system" then
                          table.insert(system_content, msg.content)
                        else
                          table.insert(other_messages, msg)
                        end
                      end
                      local final_messages = {}
                      if #system_content > 0 then
                        table.insert(final_messages, {
                          role = "system",
                          content = table.concat(system_content, "\n\n"),
                        })
                      end
                      for _, msg in ipairs(other_messages) do
                        table.insert(final_messages, msg)
                      end
                      local openai = require "codecompanion.adapters.http.openai"
                      return openai.handlers.form_messages(self, final_messages)
                    end,
                    parse_message_meta = function(self, data)
                      local extra = data.extra
                      if extra and extra.reasoning_content then
                        data.output.reasoning = { content = extra.reasoning_content }
                        if data.output.content == "" then
                          data.output.content = nil
                        end
                      end
                      return data
                    end,
                  },
                })
              end
            '';
          };
        };
      };
      opts = {
        send_code = true;
      };
    };
  };
  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>at";
      action = ":CodeCompanionChat Toggle<CR>";
      options = {
        desc = "CodeCompanion Toggle";
      };
    }
  ];
}
