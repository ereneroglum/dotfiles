{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-tools
    cppcheck
    gcc
  ];
}
