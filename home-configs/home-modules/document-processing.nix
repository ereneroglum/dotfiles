{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    doxygen
    gnuplot_qt
    groff
    pandoc
    plantuml
    sphinx
    texlive.combined.scheme-full
  ];
}
