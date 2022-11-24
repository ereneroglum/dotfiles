{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    heroic
    libselinux
    prismlauncher
  ];
}
