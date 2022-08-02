{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Eren Eroğlu";
    userEmail = "108634315+eroglueren@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "master";
      pull.ff = "only";
    };
  };
}
