{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    binutils
    file
    gdb
    iaito
    lsof
    ltrace
    radare2
    valgrind
  ];
}
