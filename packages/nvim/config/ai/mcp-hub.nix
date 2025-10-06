{ mcp-hub, mcp-hub-nvim, ... }:
{
  extraPlugins = [ mcp-hub-nvim ];
  extraConfigLua = # Lua
    ''
      require("mcphub").setup({
        cmd = "${mcp-hub}/bin/mcp-hub",
        config = "${./mcp-hub-servers.json}",
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          }
        },
        disabled_tools = {
            "list_files",    -- Built-in file operations
            "search_files",
            "read_file",
            "create_file",
            "rename_file",
            "delete_file",
            "create_dir",
            "rename_dir",
            "delete_dir",
            "bash",         -- Built-in terminal access
        },
      })
    '';
}
