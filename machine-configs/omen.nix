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
    ./nixos-modules/nvidia.nix
    ./nixos-modules/plasma.nix
    ./nixos-modules/printing.nix
    ./nixos-modules/sound.nix
    ./nixos-modules/xorg.nix
    ./nixos-modules/zram.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "sd_mod"
      "sr_mod"
      "ums_realtek"
      "usb_storage"
      "usbhid"
      "xhci_pci"
    ];
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "xfs";
  };

  networking = {
    hostName = "nixos";
    useDHCP = false;
    enableIPv6 = false;
    interfaces.enp5s0.ipv4.addresses = [{
      address = "192.168.1.3";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    firewall = {
      allowedUDPPorts = [ 51000 ];
      allowedTCPPorts = [ 25565 51000 ];
    };
  };

  users.users.eren = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}

