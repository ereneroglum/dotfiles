{ config, pkgs, ... }:

{
  imports = map (i: "${./home-modules}/${i}")
    (builtins.attrNames (builtins.readDir ./home-modules));

  home = {
    username = "eren";
    homeDirectory = "/home/eren";
    stateVersion = "22.11";
    packages = with pkgs; [
      ark
      fd
      htop
      kate
      keepassxc
      man-pages
      man-pages-posix
      okteta
      openssl_3
      ripgrep
      silver-searcher
      xclip
    ];
  };

  home.file."Templates".source = ./templates;

  programs.home-manager.enable = true;
}
