{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    cascadia-code
    nerdfonts
    noto-fonts
  ];
}
