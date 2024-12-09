{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "oil-git-status";
      src = pkgs.fetchFromGitHub {
        owner = "refractalize";
        repo = "oil-git-status.nvim";
        rev = "a7ea816bac0cc3b8b4c3605e2f2b87960be60a05";
        hash = "sha256-IXjpuzWipF7Pjp4N92ZuNKktYNe5oTYzyCykqkmNRkg=";
      };
    })
  ];

  extraConfigLua = # Lua
    ''
      require('oil-git-status').setup({
        show_ignored = true -- show files that match gitignore with !!
      })
    '';
}
