{
  config,
  lib,
  sops,
  ...
}:
{
  config = lib.mkIf config.opt.features.k3s.enable {
    services.k3s = {
      enable = true;
      role = "server";
      token = sops.secrets.k3s-token.content;
      clusterInit = config.opt.features.k3s.clusterInit;
      serverAddr = config.opt.features.k3s.serverAddr;
    };
  };
}
