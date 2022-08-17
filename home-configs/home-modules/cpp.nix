{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    autoconf
    automake
    clang-tools
    cmake
    cppcheck
    gcc
    gnumake
    libtool
  ];
}
