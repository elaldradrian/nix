{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "3b021026157487ad568e84f8082f2230b614e3e9";
        hash = "sha256-oszQHDZRJ/UR1LqiM3BEscxDmNTfvDh+UpuEDNTpJCM=";
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
