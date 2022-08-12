{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nasm
    yasm
  ];
}
