{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "bash";
        args = [ "--login" ];
      };
      window.dynamic_padding = true;
      font = {
        normal.family = "JetBrains Mono Nerd Font Mono";
        size = 9.5;
      };
      colors = {
        cursor = {
          cursor = "#cccccc";
          text = "#1d1f21";
        };
        primary = {
          background = "#1E1E1E";
          foreground = "#D4D4D4";
        };
        normal = {
          black = "#000000";
          blue = "#2472c8";
          cyan = "#11a8cd";
          green = "#0dbc79";
          magenta = "#bc3fbc";
          red = "#cd3131";
          white = "#e5e5e5";
          yellow = "#e5e510";
        };
        bright = {
          black = "#666666";
          blue = "#3b8eea";
          cyan = "#29b8db";
          green = "#23d18b";
          magenta = "#d670d6";
          red = "#f14c4c";
          white = "#e5e5e5";
          yellow = "#f5f543";
        };
      };
      bell = {
        animation = "EaseOutQuad";
        duration = 500;
      };
    };
  };
}
