{ config, pkgs, ... }:

{
  programs = {
    alacritty = {
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
            background = "#1E1E1E";
            foreground = "#D4D4D4";
          };
          cursor = {
            text = "#1d1f21";
            cursor = "#cccccc";
          };
          normal = {
            black = "#000000";
            red = "#cd3131";
            green = "#0dbc79";
            yellow = "#e5e510";
            blue = "#2472c8";
            magenta = "#bc3fbc";
            cyan = "#11a8cd";
            white = "#e5e5e5";
          };
          bright = {
            black = "#666666";
            red = "#f14c4c";
            green = "#23d18b";
            yellow = "#f5f543";
            blue = "#3b8eea";
            magenta = "#d670d6";
            cyan = "#29b8db";
            white = "#e5e5e5";
          };
        };
        bell = {
          animation = "EaseOutQuad";
          duration = 500;
        };
      };
    };
    bash = {
      enable = true;
      sessionVariables = if config.programs.neovim.enable then {
        EDITOR = "nvim";
        VISUAL = "nvim";
        MANPAGER = "nvim +Man!";
      } else { };
    };
    tmux.enable = true;
  };
}
