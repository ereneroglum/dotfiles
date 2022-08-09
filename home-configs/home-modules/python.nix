{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    python310Full
    python310Packages.autopep8
    python310Packages.flake8
    python310Packages.python-lsp-server
  ];
}
