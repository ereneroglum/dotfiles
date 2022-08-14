{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    sessionVariables = if config.programs.neovim.enable then {
      EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
    } else { };
  };
}
