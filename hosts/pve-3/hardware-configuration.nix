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
    device = "/dev/disk/by-uuid/c9f4e857-be98-42f4-b836-973a86184bf9";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/910A-CEC8";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/babd1085-aa6c-4332-958b-74ea8a067bab"; }
  ];

  networking = {
    hostName = hostname;
    hosts = {
      "127.0.0.1" = [ "localhost" ];
      "10.17.16.3" = [
        "pve-3.local.dahl-billeskov.com"
        "pve-3"
      ];
    };
    domain = "local.dahl-billeskov.com";
    defaultGateway = "10.17.16.1";
    nameservers = [ "10.17.16.1" ];
    useDHCP = false;
    interfaces.enP4p65s0.ipv4.addresses = [
      {
        address = "10.17.16.3";
        prefixLength = 23;
      }
    ];
  };

  # networking.interfaces.enP3p49s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enP4p65s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
