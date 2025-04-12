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
      (btop.overrideAttrs (old: {
        buildFlags = old.buildFlags or [ ] ++ [ "GPU_SUPPORT=true" ];
      }))
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
    google-chrome
    slack
    dbeaver-bin
  ];
in
{
  home.packages =
    commonPkgs
    ++ (if config.opt.features.desktop.enable then desktopPkgs else [ ])
    ++ (if config.opt.features.devUtils.enable then devUtilPkgs else [ ])
    ++ (if config.opt.features.docker.enable then dockerPkgs else [ ])
    ++ (if config.opt.features.work-machine.enable then work else [ ])
    ++ (if config.opt.programs.colima.enable then [ pkgs.colima ] else [ ]);
}
