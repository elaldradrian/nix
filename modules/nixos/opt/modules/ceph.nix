{ config, pkgs, ... }:
let
  mountPoint = "/mnt/backup/cephfs";
in
{
  environment.systemPackages = with pkgs; [
    stable.ceph-client
  ];

  environment.sessionVariables = {
    CEPH_ARGS = "--id rune";
  };

  environment.etc."ceph/ceph.conf".text = ''
    [global]
    fsid = 012ca50f-b724-4bc3-9b7e-7fd74f6e58b0
    mon_host = 10.17.16.2,10.17.16.4
    cephx = true
    name = client.rune
    keyring = /etc/ceph/ceph.keyring
  '';

  systemd.tmpfiles.rules = [
    "d ${mountPoint} 0755 rune users -"
  ];

  fileSystems."${mountPoint}" = {
    device = ":/";
    fsType = "ceph";
    options = [
      "mds_namespace=backup"
      "name=rune"
      "secretfile=/etc/ceph/rune.secret"

      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=10min"

      "_netdev"
      "noatime"
    ];
  };

  sops.secrets."ceph.client.rune.key" = {
    mode = "0600";
    owner = "root";
    group = "root";
  };

  sops.templates."rune.secret".content = config.sops.placeholder."ceph.client.rune.key";

  environment.etc."ceph/rune.secret".source = config.sops.templates."rune.secret".path;

  sops.templates."ceph.keyring".content = ''
    [client.rune]
    key = ${config.sops.placeholder."ceph.client.rune.key"}
  '';

  environment.etc."ceph/ceph.keyring" = {
    source = config.sops.templates."ceph.keyring".path;
    mode = "0640";
    group = "ceph";
  };
}
