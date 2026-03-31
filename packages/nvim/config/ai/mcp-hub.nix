{ mcp-hub, mcp-hub-nvim, ... }:
{
  extraPlugins = [ mcp-hub-nvim ];

  # Make compaction.lua available as require("compaction")
  extraFiles = {
    "lua/compaction.lua".source = ./lua/compaction.lua;
  };

  extraConfigLua = # Lua
    ''
      require("lz.n").load({
        "mcphub.nvim",
        ft = { "copilot-chat" },
        cmd = "MCPHub",
        lazy = true,
        after = function()
          require("mcphub").setup({
            cmd = "${mcp-hub}/bin/mcp-hub",
            config = "${./mcp-hub-servers.json}",
            extensions = {
              copilotchat = {
                enabled = true,
                convert_tools_to_functions = true,
                convert_resources_to_functions = true,
                add_mcp_prefix = false,
              },
            },
          })
        end,
      })
    '';
}
