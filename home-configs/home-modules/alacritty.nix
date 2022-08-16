{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "bash";
        args = [ "--login" ];
      };
      window = {
        opacity = 0.95;
        dynamic_padding = true;
      };
      font = {
        normal.family = "JetBrains Mono Nerd Font Mono";
        size = 9.5;
      };
      colors = {
        primary = {
          background = "#282c34";
          foreground = "#abb2bf";
        };
        normal = {
          black = "#282c34";
          red = "#e06c75";
          green = "#98c379";
          yellow = "#d19a66";
          blue = "#61afef";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#abb2bf";
        };
        bright = {
          black = "#5c6370";
          red = "#e06c75";
          green = "#98c379";
          yellow = "#d19a66";
          blue = "#61afef";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#ffffff";
        };
      };
      bell = {
        animation = "EaseOutQuad";
        duration = 500;
      };
    };
  };
}
