{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "d2a4f540dfa56e819d733e6af2e82c245ff87f6f";
        hash = "sha256-M9xMVN9B/vYAChXfoqc3VvaOicvQXO6MJD+hwxWOAPA=";
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
