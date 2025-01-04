{ pkgs, self, ... }:
{
  home.packages = with pkgs; [
    brave

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
    ceph-client

    # colima
    docker
    docker-compose

    self.packages.${pkgs.system}.nvim
    # slack
    # dbeaver-bin
    # postman
  ];
}
