{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wezterm

    nodejs
    node2nix
    python3

    btop
    dig
    p7zip
    gh
    fzf
    jq
    yq
    kubectl
    ripgrep

    colima
    docker
    docker-compose

    slack
    dbeaver-bin
    postman
  ];
}
