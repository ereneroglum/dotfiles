{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    doxygen
    gnuplot_qt
    groff
    libreoffice
    pandoc
    plantuml
    sphinx
    texlive.combined.scheme-full
  ];
}
