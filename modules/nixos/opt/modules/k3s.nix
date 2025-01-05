{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.opt.features.k3s.enable {
    services.k3s = {
      enable = true;
      role = "server";
      tokenFile = config.sops.secrets.k3s-token.path;
      clusterInit = config.opt.features.k3s.clusterInit;
      serverAddr = config.opt.features.k3s.serverAddr;
    };
  };
}
