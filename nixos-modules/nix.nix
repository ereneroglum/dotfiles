{ config, pkgs, ... }:

{
  nixpkgs = {
    allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = "22.11";
}
