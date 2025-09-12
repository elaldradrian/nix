{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "52f1076b266286dc3366c461e6dffe87c0d05c08";
        hash = "sha256-Xu6ZGnqvTsoHLeAVa0sNnhge9Di83ilT3XzYiM6aA/I=";
      };
    })
  ];

  extraConfigLua = # Lua
    ''
      require('nebulous').setup({
        variant = "twilight",
      })
    '';
}
