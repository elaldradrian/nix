{
  config,
  pkgs,
  self,
  ...
}:
let
  desktop = with pkgs; [
    brave
    pulseaudio
    xorg.xeyes
  ];

  devUtils = with pkgs; [
    nodejs
    node2nix
    python3
  ];

  docker = with pkgs.docker; [
    docker
    docker-compose
  ];

  commonPackages = with pkgs; [
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
    commonPackages
    ++ (if config.opt.features.desktop.enable then desktop else [ ])
    ++ (if config.opt.features.devUtils.enable then devUtils else [ ])
    ++ (if config.opt.features.docker.enable then docker else [ ])
    ++ (if config.opt.programs.nvim.enable then [ self.packages.${pkgs.system}.nvim ] else [ ])
    ++ (if config.opt.programs.colima.enable then [ pkgs.colima ] else [ ])
    ++ (if config.opt.programs.slack.enable then [ pkgs.slack ] else [ ])
    ++ (if config.opt.programs.dbeaver.enable then [ pkgs.dbeaver-bin ] else [ ]);
}
