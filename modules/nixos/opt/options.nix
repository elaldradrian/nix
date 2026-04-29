{ lib, ... }:
{
  options.opt = with lib; {
    features = {
      backup-vault.enable = mkEnableOption "Enable Backup Vault";
      ceph.enable = mkEnableOption "Enable Ceph client";
      desktop.enable = mkEnableOption "Enable desktop";
      docker.enable = mkEnableOption "Enable docker";
      k3s = {
        enable = mkEnableOption "Enable k3s";
        clusterInit = mkEnableOption "Initialize k3s cluster";
        serverAddr = mkOption {
          type = types.str;
          default = "";
        };
      };
      vpn.enable = mkEnableOption "Enable VPN";
      llama-cpp.enable = mkEnableOption "Enable llama-cpp";
    };
    programs = {
      steam = {
        enable = mkEnableOption "Enable Steam";
      };
    };
  };
}
