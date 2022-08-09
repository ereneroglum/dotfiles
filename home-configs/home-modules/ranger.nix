{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
  ];

  xdg.configFile."ranger/rc.conf".text = ''
    set show_hidden true
    set draw_borders true
  '';
}
