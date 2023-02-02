{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    heroic
    yuzu
    libselinux
    prismlauncher-qt5 # Temprory for theming, will be changed to prismlauncher when breeze is available for qt6
  ];
}
