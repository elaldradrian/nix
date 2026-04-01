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
                      default = 'qwen3.5-35b-a3b';
                      choices = {
                        ["qwen3.5-9b"] = { opts = { can_reason = false } },
                        "qwen3.5-35b-a3b",
                      },
                    },
                    num_ctx = {
                      default = 65536,
                    },
                    temperature = {
                      default = 0.6;
                    };
                  },
                  handlers = {
                    form_messages = function(self, messages)
                      local system_content = {}
                      local other_messages = {}
                      -- 1. Separate system messages from everything else
                      for _, msg in ipairs(messages) do
                        if msg.role == "system" then
                          table.insert(system_content, msg.content)
                        else
                          table.insert(other_messages, msg)
                        end
                      end
                      local final_messages = {}
                      -- 2. If there are system messages, merge them into ONE message at the top
                      if #system_content > 0 then
                        table.insert(final_messages, {
                          role = "system",
                          content = table.concat(system_content, "\n\n"),
                        })
                      end
                      -- 3. Append all the user/assistant messages
                      for _, msg in ipairs(other_messages) do
                        table.insert(final_messages, msg)
                      end
                      -- 4. Pass the cleaned messages to the standard OpenAI handler
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
      strategies = {
        agent = {
          adapter = "llama";
        };
        chat = {
          adapter = "llama";
        };
        inline = {
          adapter = "llama";
        };
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
