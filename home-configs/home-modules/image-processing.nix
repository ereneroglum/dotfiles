{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    asymptote
    gimp
    graphviz
    imagemagick
    inkscape
    krita
    netpbm
  ];
}
