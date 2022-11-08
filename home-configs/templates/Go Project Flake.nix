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
          @packagename@ = pkgs.buildGoModule {
            pname = "@packagename@";
            version = "@packageversion@";
            src = ./.;
            vendorSha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          };
        };

        defaultPackage = packages.@packagename@;

        devShell = pkgs.mkShell {
          packages = with pkgs; [ gopls ];
          inputsFrom = [ packages.@packagename@ ];
        };
      }
    );
}
