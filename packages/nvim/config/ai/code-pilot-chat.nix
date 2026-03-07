{
  plugins.copilot-chat = {
    enable = true;
    lazyLoad.settings = {
      cmd = [
        "CopilotChat"
        "CopilotChatToggle"
        "CopilotChatModels"
        "CopilotChatOpen"
        "CopilotChatClose"
        "CopilotChatReset"
        "CopilotChatExplain"
        "CopilotChatFix"
        "CopilotChatOptimize"
        "CopilotChatDocs"
        "CopilotChatTests"
      ];
    };
    settings = {
      mappings = {
        reset = {
          normal = "<leader>an";
          insert = "";
        };
      };
      window = {
        layout = "vertical";
        width = 0.25;
      };
      providers = {
        ollama = {
          get_url.__raw = ''
            function()
              return "http://localhost:11434/v1/chat/completions"
            end
          '';

          get_headers.__raw = ''
            function()
              return {}
            end
          '';

          prepare_input.__raw = ''
            require("CopilotChat.config.providers").copilot.prepare_input
          '';
          prepare_output.__raw = ''
            require("CopilotChat.config.providers").copilot.prepare_output
          '';

          get_models.__raw = ''
            function(headers)
              local curl = require("CopilotChat.utils.curl")

              local tags, err = curl.get("http://localhost:11434/api/tags", {
                headers = headers,
                json_response = true,
              })
              if err then error(err) end

              local models = {}

              for _, m in ipairs(tags.body.models or {}) do
                local show, err2 = curl.post("http://localhost:11434/api/show", {
                  headers = headers,
                  json_request = true,
                  json_response = true,
                  body = { model = m.name },
                })

                local caps = {}
                local ctx_len = nil
                local version = nil

                if not err2 and show and show.body then
                  caps = show.body.capabilities or {}
                  version = show.body.modified_at

                  local model_info = show.body.model_info or {}
                  ctx_len =
                    model_info["qwen2.context_length"]
                    or model_info["llama.context_length"]
                    or model_info["general.context_length"]

                  if type(ctx_len) == "string" then
                    ctx_len = tonumber(ctx_len)
                  end
                end

                table.insert(models, {
                  id = m.name,
                  name = m.name,
                  tokenizer = "o200k_base",
                  max_input_tokens = ctx_len,
                  max_output_tokens = nil,
                  streaming = true,
                  tools = vim.tbl_contains(caps, "tools") or false,
                  reasoning = vim.tbl_contains(caps, "thinking") or false,
                  version = version,
                })
              end

              return models
            end
          '';
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
      action = ":CopilotChatToggle<CR>";
      options = {
        desc = "CopilotChat Toggle (cmd)";
      };
    }
  ];
}
