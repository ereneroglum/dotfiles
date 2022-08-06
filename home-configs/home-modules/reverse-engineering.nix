{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    binutils
    file
    gdb
    ltrace
    radare2
    valgrind
  ];
}
