{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  shellHook = ''
    SHELL=${pkgs.bashInteractive}/bin/bash
  '';
  packages = with pkgs; [ bashInteractive rnix-lsp ];
}
