{
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
    };
    kernelModules = [
      "kvm-amd"
    ];
    extraModulePackages = [ ];
    kernel.sysctl."kernel.perf_event_paranoid" = -1;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/dc6ee6e0-8cfa-4715-abf4-6953b6e01a54";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/92A2-EAA0";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  networking = {
    useDHCP = lib.mkDefault true;
    firewall = {
      allowedTCPPorts = [
        11434
      ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  services.xserver.videoDrivers = [
    "amdgpu"
  ];

  hardware = {
    keyboard.qmk.enable = true;
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    amdgpu.initrd.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
