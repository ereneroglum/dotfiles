{ config, pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    bindings = {
      "ALT+k" = "add sub-scale +0.1";
      "ALT+j" = "add sub-scale -0.1";
      "[" = "add speed -0.1";
      "]" = "add speed 0.1";
    };
    config = {
      hwdec = "auto";
    };
  };
}
