{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    binutils
    file
    gdb
    iaito
    ltrace
    radare2
    valgrind
  ];
}
