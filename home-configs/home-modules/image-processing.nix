{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    asymptote
    gimp
    graphviz
    imagemagick
    krita
    netpbm
  ];
}
