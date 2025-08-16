{
  config,
  ...
}:
{
  environment.etc."ceph/ceph.conf".text = ''
    [global]
    fsid = 012ca50f-b724-4bc3-9b7e-7fd74f6e58b0
    mon_host = 10.17.16.2,10.17.16.4
    cephx = true
  '';

  sops.secrets."ceph.client.rune.key" = {
    mode = "0600";
    owner = "root";
    group = "root";
  };
  sops.templates."ceph.client.rune.keyring".content = ''
    [client.rune]
    key = ${config.sops.placeholder."ceph.client.rune.key"}
  '';

  environment.etc."ceph/ceph.client.rune.keyring".source =
    config.sops.templates."ceph.client.rune.keyring".path;
}
