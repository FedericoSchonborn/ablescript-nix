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
        ablescript = pkgs.callPackage ./packages/ablescript.nix {
          version = "0.5.2";
          sha256 = "wFmg9BTo2+JSVabWDIQAoLdT7OYuMxLxlvq6yL8g4EM=";
          cargoSha256 = "2tBb8FdXknTbgFrjfO5ZM3O9OAnVuLVY/YcL8y/W7nA=";
        };

        ablescript-unstable = pkgs.callPackage ./packages/ablescript.nix {
          version = "unstable-2022-09-20";
          commit = "8ef7118dc1270386d5455e4d407a272a0c7b0724";
          sha256 = "5UVuyTEKFpq7DcTn7HHNBOv874MvNwH83CWjtMFXBgA=";
          cargoSha256 = "wa1D+C3d+pFhUo8wexCbfv5A/O3QyXaE6xBRH/JclWg=";
        };

        default = ablescript;
      };

      overlays = rec {
        ablescript = final: prev: {
          ablescript = packages.${prev.system}.ablescript;
          ablescript-unstable = packages.${prev.system}.ablescript-unstable;
        };

        default = ablescript;
      };

      formatter = pkgs.alejandra;
    });
}
