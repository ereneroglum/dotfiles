{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ git fd ripgrep ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
  };

  xdg.configFile."nvim/init.lua".source = ./init.lua;
  xdg.configFile."nvim/lua".source = ./lua;
}
