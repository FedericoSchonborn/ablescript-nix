{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    ablescript0_5_2-src = {
      # v0.5.2
      url = "git+https://git.ablecorp.us/AbleScript/able-script?rev=daca854db4b8fa61f49212a1735e7ffc2d228850";
      flake = false;
    };

    ablescript0_5-src = {
      # v0.5.0
      url = "git+https://git.ablecorp.us/AbleScript/able-script?rev=70d6bf661fa89524c72a3ad8ca8027bf9c34000c";
      flake = false;
    };

    ablescript0_4-src = {
      # v0.4.0
      url = "git+https://git.ablecorp.us/AbleScript/able-script?rev=cda63c733cb5daff66b596f27ec5765aab227d35";
      flake = false;
    };

    ablescript0_3-src = {
      # v0.3.0
      url = "git+https://git.ablecorp.us/AbleScript/able-script?rev=a4e3b98c6a89839557fbbf85d83626c99bb5b126";
      flake = false;
    };

    ablescript0_2-src = {
      # v0.2.0
      url = "git+https://git.ablecorp.us/AbleScript/able-script?rev=5293cd960773f179b0f1cf314aaa993288ebcf23";
      flake = false;
    };

    ablescript-unstable-src = {
      url = "git+https://git.ablecorp.us/AbleScript/able-script?rev=8ef7118dc1270386d5455e4d407a272a0c7b0724";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ablescript0_5_2-src,
    ablescript0_5-src,
    ablescript0_4-src,
    ablescript0_3-src,
    ablescript0_2-src,
    ablescript-unstable-src,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in rec {
      packages = rec {
        ablescript0_5_2 = pkgs.callPackage ./packages/ablescript.nix {
          version = "0.5.2";
          src = ablescript0_5_2-src;
        };

        ablescript0_5 = pkgs.callPackage ./packages/ablescript.nix {
          version = "0.5.0";
          src = ablescript0_5-src;
        };

        ablescript0_4 = pkgs.callPackage ./packages/ablescript.nix {
          version = "0.4.0";
          src = ablescript0_4-src;
        };

        ablescript0_3 = pkgs.callPackage ./packages/ablescript.nix {
          version = "0.3.0";
          src = ablescript0_3-src;
        };

        ablescript0_2 = pkgs.callPackage ./packages/ablescript.nix {
          version = "0.2.0";
          src = ablescript0_2-src;
        };

        ablescript-unstable = pkgs.callPackage ./packages/ablescript.nix {
          stable = false;
          version = "unstable-2022-09-20";
          src = ablescript-unstable-src;
        };

        ablescript = ablescript0_5_2;
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
