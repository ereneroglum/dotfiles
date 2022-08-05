{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    home-manager = {
      url = github:nix-community/home-manager;
    };
  };

  description = "Flake for building user environment";

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.eren = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };

      nixosConfigurations.omen = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./machines/omen.nix
          ./nixos-modules/boot.nix
          ./nixos-modules/documentation.nix
          ./nixos-modules/gpg.nix
          ./nixos-modules/locales.nix
          ./nixos-modules/nix.nix
          ./nixos-modules/nvidia.nix
          ./nixos-modules/plasma.nix
          ./nixos-modules/printing.nix
          ./nixos-modules/sound.nix
          ./nixos-modules/xorg.nix
        ];
      };

      nixosConfigurations.pavilion = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./machines/pavilon.nix
          ./nixos-modules/boot.nix
          ./nixos-modules/documentation.nix
          ./nixos-modules/gpg.nix
          ./nixos-modules/locales.nix
          ./nixos-modules/nix.nix
          ./nixos-modules/nvidia-offload.nix
          ./nixos-modules/nvidia.nix
          ./nixos-modules/plasma.nix
          ./nixos-modules/printing.nix
          ./nixos-modules/sound.nix
          ./nixos-modules/xorg.nix
        ];
      };
    };
}
