{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Eren Eroğlu";
    userEmail = "108634315+ereneroglum@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "master";
      pull.ff = "only";
    };
  };
}
