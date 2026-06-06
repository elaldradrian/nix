{
  config,
  pkgs,
  lib,
  self,
  ...
}:
{
  config = lib.mkIf config.opt.features.k3s.enable {
    sops.secrets.k3s-token = {
      sopsFile = "${self}/secrets/k3s/secrets.json";
    };

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
      package = pkgs.k3s_1_32;
    };
    networking.firewall = {
      allowedTCPPorts = [
        6443 # k3s API server
        2379 # etcd clients (HA embedded)
        2380 # etcd peers (HA embedded)
        10250 # kubelet metrics — metrics-server scrapes /metrics/resource here
      ];
      allowedUDPPorts = [ 8472 ]; # flannel VXLAN
    };
  };
}
