{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {nixpkgs, ...}: let
    # TODO: macOS support?
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
  in rec {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      ablescript0_5_2 = pkgs.callPackage ./packages/ablescript {
        version = "0.5.2";
        sha256 = "3AvAqeZmH5foGS0blKbMdQbXgnAY6lNxNnYJhF9GAys=";
        cargoSha256 = "2tBb8FdXknTbgFrjfO5ZM3O9OAnVuLVY/YcL8y/W7nA=";
      };

      ablescript0_5 = pkgs.callPackage ./packages/ablescript {
        version = "0.5.0";
        sha256 = "FVtyVO54YANMnAZyKyw9/8RvrrMwqQqyEKu/S4rSfs4=";
        cargoSha256 = "Sua2KUv+ucq+80ypOw+T/TkC5waoSTxjxEJtHR4nxX0=";
      };

      ablescript0_4 = pkgs.callPackage ./packages/ablescript {
        version = "0.4.0";
        sha256 = "9RJ/CHdj+hQO9q/GMksvOo1YK1CLkDe8F3hRjb6sSDI=";
        cargoSha256 = "MBPiqTE6H4qbidtTnSIBtYoMHb6mOG9hW0/LBLJ+N3M=";
      };

      ablescript0_3 = pkgs.callPackage ./packages/ablescript {
        version = "0.3.0";
        sha256 = "PfiGzsrzPzwRFQgJLJjt8fZyYpkqZuPK3z8B2fp78s4=";
        cargoSha256 = "/M7VuFhvR34QNo5a1lcwuYXm8QDQG0eYkoPYaLpWkZQ=";
      };

      ablescript0_2 = pkgs.callPackage ./packages/ablescript {
        version = "0.2.0";
        sha256 = "oKVbvm8DzCbLDPYc8MnmT9/ECK5yq1CgC6/vMRxz1r0=";
        cargoSha256 = "Q+uR+0H/YruwWVfd/nMwicsfes7hVFrRVpmZuBd2gS4=";
      };

      ablescript-unstable = pkgs.callPackage ./packages/ablescript {
        stable = false;
        version = "unstable-2022-11-04";
        rev = "1a9cf6c2a640fd0815ddfee63b737ecafa48e3c8";
        sha256 = "L2KxlHRBPXMDywMqWVX7ua+d8ceeoDJnSfFJIbjGiRM=";
        cargoSha256 = "172i2RW7CFT5t139hkdLZbsalp9mB+5udKDceXTHOqI=";
      };

      ablescript = ablescript0_5_2;
      default = ablescript;
    });

    overlays = rec {
      ablescript = self: super: {
        ablescript = packages.${super.system}.ablescript;
        ablescript-unstable = packages.${super.system}.ablescript-unstable;
      };

      default = ablescript;
    };

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          just
        ];
      };
    });

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  nixConfig = {
    extra-substituters = [
      "https://ablescript.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ablescript.cachix.org-1:ohFVmuceKGwQHeCRRxP8bZeaPX9c+Yl0wU+yHy7NM4M="
    ];
  };
}
