{ pkgs, self, ... }:
{
  home.packages = with pkgs; [
    wezterm
    zoxide

    nodejs
    node2nix
    python3

    btop
    dig
    p7zip
    gh
    fzf
    fd
    jq
    yq
    kubectl
    ripgrep

    colima
    docker
    docker-compose

    self.packages.${pkgs.system}.nvim
    slack
    dbeaver-bin
    postman
  ];
}
