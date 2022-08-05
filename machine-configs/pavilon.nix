{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./machines/pavilon.nix
    ./nixos-modules/boot.nix
    ./nixos-modules/documentation.nix
    ./nixos-modules/gpg.nix
    ./nixos-modules/locales.nix
    ./nixos-modules/nix.nix
    ./nixos-modules/nvidia-offload.nix
    ./nixos-modules/nvidia.nix
    ./nixos-modules/plasma.nix
    ./nixos-modules/printing.nix
    ./nixos-modules/sound.nix
    ./nixos-modules/xorg.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_5_18;
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "xfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  networking = {
    hostName = "pavilion";
    networkmanager.enable = true;
  };

  services.openssh.enable = true;

  hardware = {
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
    nvidia.prime = {
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  users.users.eren = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}

