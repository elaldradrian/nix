{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernel.sysctl."kernel.perf_event_paranoid" = -1;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4cd4b0db-e971-4acd-8987-9dda6f7f7731";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/21B1-D76C";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/62c9445e-e2ad-4e45-98c4-4dd24bcc3f24"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    useDHCP = lib.mkDefault true;
    firewall = {
      allowedTCPPorts = [
        11434
        50052
      ];
    };
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  powerManagement.cpuFreqGovernor = "powersave";
}
