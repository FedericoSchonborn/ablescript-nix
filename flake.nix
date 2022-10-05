{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in rec {
      packages = rec {
        ablescript = pkgs.callPackage ./packages/ablescript.nix {};
        default = ablescript;
      };

      overlays = rec {
        ablescript = final: prev: {
          ablescript = packages.${prev.system}.ablescript;
        };
        default = ablescript;
      };

      formatter = pkgs.alejandra;
    });
}
