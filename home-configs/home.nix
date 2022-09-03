{ config, pkgs, ... }:

{
  imports = [
    ./home-modules/alacritty.nix
    ./home-modules/assembly.nix
    ./home-modules/bash.nix
    ./home-modules/cpp.nix
    ./home-modules/document-processing.nix
    ./home-modules/emacs.nix
    ./home-modules/fonts.nix
    ./home-modules/gaming.nix
    ./home-modules/git.nix
    ./home-modules/go.nix
    ./home-modules/helix.nix
    ./home-modules/image-processing.nix
    ./home-modules/mpv.nix
    ./home-modules/neovim.nix
    ./home-modules/nix.nix
    ./home-modules/online.nix
    ./home-modules/python.nix
    ./home-modules/ranger.nix
    ./home-modules/reverse-engineering.nix
    ./home-modules/rust.nix
  ];


  home = {
    username = "eren";
    homeDirectory = "/home/eren";
    stateVersion = "22.11";
    packages = with pkgs; [
      htop
      kate
      keepassxc
      man-pages
      man-pages-posix
      openssl_3
      xclip
    ];
  };

  programs = {
    home-manager.enable = true;
    tmux.enable = true;
  };
}
