{
  config,
  pkgs,
  self,
  ...
}:
let
  desktopPkgs = with pkgs; [
    brave
    pulseaudio
  ];

  devUtilPkgs = with pkgs; [
    nodejs
    node2nix
    python3
  ];

  dockerPkgs = with pkgs; [
    docker
    docker-compose
  ];

  commonPkgs = with pkgs; [
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
    # ceph-client
    age
    sops
  ];
in
{
  home.packages =
    commonPkgs
    ++ (if config.opt.features.desktop.enable then desktopPkgs else [ ])
    ++ (if config.opt.features.devUtils.enable then devUtilPkgs else [ ])
    ++ (if config.opt.features.docker.enable then dockerPkgs else [ ])
    ++ (if config.opt.programs.nvim.enable then [ self.packages.${pkgs.system}.nvim ] else [ ])
    ++ (if config.opt.programs.colima.enable then [ pkgs.colima ] else [ ])
    ++ (if config.opt.programs.slack.enable then [ pkgs.slack ] else [ ])
    ++ (if config.opt.programs.dbeaver.enable then [ pkgs.dbeaver-bin ] else [ ]);
}
