{
  plugins.avante = {
    enable = true;
    # lazyLoad.settings.event = "DeferredUIEnter";
    settings = {
      provider = "copilot";
      system_prompt.__raw = # Lua
        ''
          function()
            local hub = require("mcphub").get_hub_instance()
            return hub and hub:get_active_servers_prompt() or ""
          end
        '';
      custom_tools.__raw = # Lua
        ''
          function()
            return {
                require("mcphub.extensions.avante").mcp_tool(),
            }
          end
        '';
      behaviour = {
        auto_apply_diff_after_generation = false;
      };
      disabled_tools = [
        "list_files"
        "search_files"
        "read_file"
        "create_file"
        "rename_file"
        "delete_file"
        "create_dir"
        "rename_dir"
        "delete_dir"
        "bash"
      ];
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
