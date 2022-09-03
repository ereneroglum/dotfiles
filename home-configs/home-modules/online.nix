{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    qbittorrent
    thunderbird
    tor
    weechat
    wget
  ];
}
