{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    firefox
    qbittorrent
    tor
    weechat
    wget
  ];
}
