{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    libselinux
    polymc
  ];
}
