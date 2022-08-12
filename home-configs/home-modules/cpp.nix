{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    autoconf
    automake
    clang-tools
    cmake
    cppcheck
    doxygen
    gcc
    gnumake
    libtool
  ];
}
