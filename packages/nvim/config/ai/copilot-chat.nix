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
        width = 0.35;
      };
      model = "qwen3.5-9b";
      providers = {
        llama-cpp = {
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
              local tags, err = curl.get("http://localhost:11434/v1/models", {
                headers = headers,
                json_response = true,
              })
              if err then error(err) end
              local models = {}
              for _, m in ipairs(tags.body.data or {}) do
                table.insert(models, {
                  id = m.id,
                  name = m.id,
                  tokenizer = "o200k_base",
                  max_input_tokens = 24000,
                  max_output_tokens = 24000,
                  streaming = true,
                  tools = true,
                  reasoning = true,
                  version = nil,
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
    {
      mode = "n";
      key = "<leader>a?";
      action = ":CopilotChatModels<CR>";
      options = {
        desc = "CopilotChat Models (cmd)";
      };
    }
  ];
}
