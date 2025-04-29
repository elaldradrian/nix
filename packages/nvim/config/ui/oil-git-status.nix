{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "oil-git-status";
      src = pkgs.fetchFromGitHub {
        owner = "refractalize";
        repo = "oil-git-status.nvim";
        rev = "4b5cf53842c17a09420919e655a6a559da3112d7";
        hash = "sha256-V1tR6U3SAufrPwjSmVXIfhWyaDcF/I48/r2nuCc1/Ms=";
      };
      dependencies = [ pkgs.vimPlugins.oil-nvim ];
    })
  ];

  extraConfigLua = # Lua
    ''
      require('oil-git-status').setup({
        show_ignored = true -- show files that match gitignore with !!
      })
    '';
}
