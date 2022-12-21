{ config, pkgs, ... }:

{
  boot = {
    kernel.sysctl."kernel.sysrq" = 1;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "1920x1080";
      };
    };
    tmpOnTmpfs = true;
  };
}
