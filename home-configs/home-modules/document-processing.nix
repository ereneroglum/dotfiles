{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # ghostscript # included with texlive
    asciidoc-full
    asciidoctor
    dblatexFull
    doxygen
    gnuplot_qt
    groff
    pandoc
    plantuml
    sphinx
    texinfo
    texlive.combined.scheme-full
  ];
}
