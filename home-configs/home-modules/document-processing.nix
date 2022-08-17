{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    groff
    pandoc
    texlive.combined.scheme-full
  ];
}
