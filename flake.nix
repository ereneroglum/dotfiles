{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    home-manager.url = github:nix-community/home-manager;
  };

  description = "Flake for building user environment";

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.eren = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-configs/home.nix ];
      };

      nixosConfigurations.omen = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./machine-configs/omen.nix ];
      };

      nixosConfigurations.pavilion = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./machine-configs/pavilon.nix ];
      };

      devShells.${system}.default = import ./shell.nix { inherit pkgs; };
    };
}
