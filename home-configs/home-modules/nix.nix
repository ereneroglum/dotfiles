{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    deadnix
    nixfmt
    rnix-lsp
  ];
}
