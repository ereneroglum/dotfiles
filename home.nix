{ config, pkgs, ... }:

{
  imports = [
    ./home-modules/alacritty.nix
    ./home-modules/bash.nix
    ./home-modules/emacs.nix
    ./home-modules/fonts.nix
    ./home-modules/git.nix
    ./home-modules/helix.nix
    ./home-modules/mpv.nix
    ./home-modules/neovim.nix
    ./home-modules/ranger.nix
  ];


  home = {
    username = "eren";
    homeDirectory = "/home/eren";
    stateVersion = "22.11";
    packages = with pkgs; [
      discord
      firefox
      htop
      kate
      keepassxc
      man-pages
      man-pages-posix
      qbittorrent
      tor
      weechat
    ];
  };

  programs = {
    home-manager.enable = true;
    tmux.enable = true;
  };

  nixpkgs.overlays = [
    (self: super: {
      qbittorrent = super.qbittorrent.overrideAttrs (old: {
        version = "4.4.2";
        src = super.fetchFromGitHub {
          owner = "qbittorrent";
          repo = "qBittorrent";
          rev = "release-4.4.2";
          sha256 = "sha256-xBNN9YYKMDcoL1wvERjlAjV8vb2GVgwwlHtb5y0+f+8=";
        };
      });
    })
  ];

}
