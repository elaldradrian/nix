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
    pulsemixer
    wineWowPackages.stagingFull
    winetricks
  ];

  devUtilPkgs = with pkgs; [
    nodejs
    node2nix
    python3
    argocd
  ];

  dockerPkgs = with pkgs; [
    docker
    docker-compose
  ];

  commonPkgs =
    with pkgs;
    [
      self.packages.${pkgs.system}.nvim
      (btop.override { cudaSupport = true; })
      dig
      p7zip
      gh
      fzf
      fd
      jq
      yq
      kubectl
      ripgrep
      age
      sops
    ]
    ++ (if pkgs.stdenv.isDarwin then [ ] else [ pkgs.ceph-client ]);

  work = with pkgs; [
    slack
    dbeaver-bin
  ];

  # games = with pkgs; [
  # ];
in
{
  home.packages =
    commonPkgs
    ++ (if config.opt.features.desktop.enable then desktopPkgs else [ ])
    ++ (if config.opt.features.devUtils.enable then devUtilPkgs else [ ])
    ++ (if config.opt.features.docker.enable then dockerPkgs else [ ])
    ++ (if config.opt.features.work-machine.enable then work else [ ])
    # ++ (if config.opt.features.games.enable then games else [ ])
    ++ (if config.opt.programs.colima.enable then [ pkgs.colima ] else [ ]);
}
