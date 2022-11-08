{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    file
    gdb
    iaito
    lsof
    ltrace
    radare2
    valgrind
  ];
}
