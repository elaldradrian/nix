{ config, pkgs, ... }:
let
  mountPoint = "/mnt/backup/vault";
  host = "u440489.your-storagebox.de";
  user = "u440489";
in
{
  environment.systemPackages = with pkgs; [
    sshfs
  ];
  programs.fuse.userAllowOther = true;

  systemd.tmpfiles.rules = [
    "d ${mountPoint} 0755 root root - -"
  ];

  sops.secrets."backup.vault.ssh_key" = {
    mode = "0600";
    owner = "root";
    group = "root";
  };

  environment.etc."ssh/ssh_known_hosts".text = ''
    u440489.your-storagebox.de ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA5EB5p/5Hp3hGW1oHok+PIOH9Pbn7cnUiGmUEBrCVjnAw+HrKyN8bYVV0dIGllswYXwkG/+bgiBlE6IVIBAq+JwVWu1Sss3KarHY3OvFJUXZoZyRRg/Gc/+LRCE7lyKpwWQ70dbelGRyyJFH36eNv6ySXoUYtGkwlU5IVaHPApOxe4LHPZa/qhSRbPo2hwoh0orCtgejRebNtW5nlx00DNFgsvn8Svz2cIYLxsPVzKgUxs8Zxsxgn+Q/UvR7uq4AbAhyBMLxv7DjJ1pc7PJocuTno2Rw9uMZi1gkjbnmiOh6TTXIEWbnroyIhwc8555uto9melEUmWNQ+C+PwAK+MPw==
  '';

  fileSystems."${mountPoint}" = {
    device = "${user}@${host}:/";
    fsType = "fuse.sshfs";
    options = [
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=10min"

      "_netdev"
      "reconnect"
      "ServerAliveInterval=15"
      "ServerAliveCountMax=3"

      "allow_other"

      "IdentityFile=${config.sops.secrets."backup.vault.ssh_key".path}"
      "StrictHostKeyChecking=yes"
      "UserKnownHostsFile=/etc/ssh/ssh_known_hosts"
    ];
  };
}
