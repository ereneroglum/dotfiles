{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ libsForQt5.bismuth ];

  services.xserver = {
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}
