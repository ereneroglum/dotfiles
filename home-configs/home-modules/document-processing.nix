{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    doxygen
    groff
    pandoc
    sphinx
    texlive.combined.scheme-full
  ];
}
