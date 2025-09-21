{ mcp-hub, mcp-hub-nvim, ... }:
{
  extraPlugins = [ mcp-hub-nvim ];
  extraConfigLua = # Lua
    ''
      require("mcphub").setup({
        cmd = "${mcp-hub}/bin/mcp-hub",
        config = "${./mcp-hub-servers.json}"
      })
    '';
}
