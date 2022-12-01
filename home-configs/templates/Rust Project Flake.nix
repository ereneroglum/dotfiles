{
  description = "Flake to build @packagename@";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in rec {
        packages = flake-utils.lib.flattenTree {
          @packagename@ = pkgs.rustPlatform.buildRustPackage {
            pname = "@packagename@";
            version = "@packageversion@";
            src = ./.;
            cargoSha256 = pkgs.lib.fakeSha256;
          };
        };

        defaultPackage = packages.@packagename@;

        devShell = pkgs.mkShell {
          shellHook = ''
            SHELL=${pkgs.bashInteractive}/bin/bash
          '';
          packages = with pkgs; [ bashInteractive rust-analyzer rustfmt ];
          inputsFrom = [ packages.@packagename@ ];
        };
      }
    );
}
