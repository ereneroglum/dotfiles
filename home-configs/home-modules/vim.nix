{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vimHugeX;
  };
}
