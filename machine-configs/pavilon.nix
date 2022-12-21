{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./nixos-modules/boot.nix
    ./nixos-modules/documentation.nix
    ./nixos-modules/gaming.nix
    ./nixos-modules/gpg.nix
    ./nixos-modules/locales.nix
    ./nixos-modules/nix.nix
    ./nixos-modules/nvidia-offload.nix
    ./nixos-modules/nvidia.nix
    ./nixos-modules/plasma.nix
    ./nixos-modules/printing.nix
    ./nixos-modules/sound.nix
    ./nixos-modules/ssh.nix
    ./nixos-modules/xorg.nix
    ./nixos-modules/zram.nix
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
    loader.grub.useOSProber = true; # Temprory fix for dual booting
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
    bluetooth.enable = true;
  };

  users.users.eren = {
    isNormalUser = true;
    extraGroups = [ "lp" "scanner" "networkmanager" "wheel" ];
  };
}

