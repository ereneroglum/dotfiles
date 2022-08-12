{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    asymptote
    graphviz
    texlive.combined.scheme-full
  ];
}
