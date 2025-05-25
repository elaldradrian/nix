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
      extraFlags = toString [
        "--debug"
        "--disable-cloud-controller"
        "--disable=traefik"
        "--disable=servicelb"
      ];
    };
    networking.firewall = {
      allowedTCPPorts = [
        6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
        2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
        2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
      ];
      allowedUDPPorts = [ 8472 ]; # k3s, flannel
    };
  };
}
