{
  plugins.avante = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";
    settings = {
      mode = "legacy";
      provider = "copilot";
      # system_prompt.__raw = # Lua
      #   ''
      #     function()
      #       local hub = require("mcphub").get_hub_instance()
      #       return hub and hub:get_active_servers_prompt() or ""
      #     end
      #   '';
      # custom_tools.__raw = # Lua
      #   ''
      #     function()
      #       return {
      #           require("mcphub.extensions.avante").mcp_tool(),
      #       }
      #     end
      #   '';
      behaviour = {
        auto_set_highlight_group = false;
        auto_approve_tool_permissions = false;
      };
      input = {
        provider = "snacks";
        provider_opts = {
          title = "Avante Input";
          icon = " ";
          placeholder = "Enter your API key...";
        };
      };
    };
  };
}
