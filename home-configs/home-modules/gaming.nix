{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bottles
    heroic
    libselinux
    lutris
    prismlauncher
  ];
}
