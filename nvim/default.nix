{ ... }: 
{
  imports = [
    ./common.nix
    ./keymap.nix

    ./ui
    ./util
    ./lsp
    ./treesitter
    ./mini
  ];
}
