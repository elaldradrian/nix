{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "Sebastian-Nielsen/better-type-hover";
      src = pkgs.fetchFromGitHub {
        owner = "Sebastian-Nielsen";
        repo = "better-type-hover";
        rev = "c91a5406775f9379a1abc16a869935beba13cfc2";
        hash = "sha256-z9s2veGEVCtB9dta2z3/3uZJog7zgLHZCaI26r5GHcs=";
      };
    })
  ];

  extraConfigLua = # Lua
    ''
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          require("better-type-hover").setup()
        end,
        once = true,
      })
    '';
}
