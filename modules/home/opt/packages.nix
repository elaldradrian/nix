{
  config,
  pkgs,
  self,
  ...
}:
let
  commonPkgs =
    with pkgs;
    [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvim
      (btop.override { rocmSupport = !pkgs.stdenv.isDarwin; })
      dig
      p7zip
      fzf
      fd
      jq
      yq
      kubectl
      ripgrep
      age
      sops
      nix-tree
      nix-output-monitor
      nh
      ncdu
    ]
    ++ (if !pkgs.stdenv.isDarwin then [ nvtopPackages.amd ] else [ ]);

  desktopPkgs = with pkgs; [
    brave
    pulseaudio
    pulsemixer
  ];

  devUtilPkgs = with pkgs; [
    nodejs
    python3
    argocd
    kubernetes-helm
    (azure-cli.override { withImmutableConfig = false; })
    gh
    qemu
    opencode
  ];

  dockerPkgs = with pkgs; [
    docker
    docker-compose
  ];

  work = with pkgs; [
    dbeaver-bin
    x3270
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
