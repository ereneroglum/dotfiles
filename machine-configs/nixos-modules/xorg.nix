{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  programs.xwayland.enable = true;
}
