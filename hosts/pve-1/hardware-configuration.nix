{
  lib,
  modulesPath,
  hostname,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "usb_storage"
    "usbhid"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/84f43348-d39e-4374-b705-02249247ebe7";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DF4B-E21F";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/3131b7bc-4733-4922-b3ac-9cc0dd1554c1"; }
  ];

  networking = {
    hostName = hostname;
    hosts = {
      "127.0.0.1" = [ "localhost" ];
      "10.17.16.2" = [
        "pve-1.local.dahl-billeskov.com"
        "pve-1"
      ];
    };
    domain = "local.dahl-billeskov.com";
    nameservers = [ "10.17.16.1" ];
    useDHCP = false;
    useNetworkd = true;
    firewall = {
      allowedTCPPorts = [
        3031
      ];
    };
  };

  systemd.network = {
    enable = true;
    wait-online.ignoredInterfaces = [
      "bond0"
      "vmbr0"
    ];

    netdevs."10-bond0" = {
      netdevConfig = {
        Name = "bond0";
        Kind = "bond";
      };
      bondConfig = {
        Mode = "802.3ad";
        MIIMonitorSec = "100ms";
        TransmitHashPolicy = "layer2+3";
      };
    };

    netdevs."20-vmbr0" = {
      netdevConfig = {
        Name = "vmbr0";
        Kind = "bridge";
      };
      bridgeConfig = {
        STP = false;
        ForwardDelaySec = 0;
        VLANFiltering = true;
      };
    };

    netdevs."30-vmbr0.100" = {
      netdevConfig = {
        Name = "vmbr0.100";
        Kind = "vlan";
      };
      vlanConfig.Id = 100;
    };

    # Bond member ports
    networks."10-bond-slaves" = {
      matchConfig.Name = "enP3p49s0 enP4p65s0";
      networkConfig.Bond = "bond0";
    };

    # Bond → bridge, trunk all VLANs (2-4092)
    networks."20-bond0" = {
      matchConfig.Name = "bond0";
      networkConfig.Bridge = "vmbr0";
      bridgeVLANs = [
        { VLAN = "2-4092"; }
      ];
    };

    # Bridge self-port, trunk all VLANs, spawn VLAN 100 sub-if
    networks."30-vmbr0" = {
      matchConfig.Name = "vmbr0";
      networkConfig.VLAN = [ "vmbr0.100" ];
      bridgeVLANs = [
        { VLAN = "2-4092"; }
      ];
    };

    # Host IP on VLAN 100
    networks."40-vmbr0.100" = {
      matchConfig.Name = "vmbr0.100";
      address = [ "10.17.16.2/23" ];
      gateway = [ "10.17.16.1" ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
