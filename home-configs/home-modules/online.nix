{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    qbittorrent
    tor
    weechat
    wget
  ];
}
