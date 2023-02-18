{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "dark_plus";
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        whitespace.render = {
          space = "all";
          tab = "all";
        };
      };
    };
  };
}
