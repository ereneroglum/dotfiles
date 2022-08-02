{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };
  };
}
