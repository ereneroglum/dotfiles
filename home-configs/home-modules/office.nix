{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    joplin-desktop
    libreoffice
    thunderbird
  ];
}
