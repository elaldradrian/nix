{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nebulous";
      src = pkgs.fetchFromGitHub {
        owner = "elaldradrian";
        repo = "nebulous.nvim";
        rev = "dfde637d60808dee5db95efed1774c9bc88ea43c";
        hash = "sha256-aN5snG3826UptSF/CwIbU+H8vOMYAOw+ND45/+C5xUs=";
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
