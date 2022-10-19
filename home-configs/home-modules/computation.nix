{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    octaveFull
    maxima
  ];
}
