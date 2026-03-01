{
  plugins.copilot-chat = {
    enable = true;
    settings = {
      debug = true;
      providers = {
        ollama = {
          # Disable if ollama is not running locally
          disabled = false;
          get_url.__raw = ''
            function()
              return "http://localhost:11434/v1/chat/completions"
            end
          '';
          get_headers.__raw = ''
            function()
              return { ["Authorization"] = "Bearer ollama" }
            end
          '';
          get_models.__raw = ''
            function()
              local response = require("CopilotChat.utils.curl").get("http://localhost:11434/api/tags", {
                json_response = true,
              })
              return vim.tbl_map(function(model)
                return {
                  id = model.name,
                  name = model.name,
                  streaming = true,
                  tools = true,
                }
              end, response.body.models or {})
            end
          '';
          prepare_input.__raw = ''
            require("CopilotChat.config.providers").copilot.prepare_input
          '';
          prepare_output.__raw = ''
            require("CopilotChat.config.providers").copilot.prepare_output
          '';
        };
      };
    };
  };
}
