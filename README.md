# AbleScript for Nix

[![Cachix](https://github.com/FedericoSchonborn/ablescript-nix/actions/workflows/cachix.yaml/badge.svg)](https://github.com/FedericoSchonborn/ablescript-nix/actions/workflows/cachix.yaml)

Nix Flake for AbleScript.

## Usage

### Using `nix run`

```sh
$ nix run github:FedericoSchonborn/ablescript-nix#ablescript
Hi [AbleScript 0.5.2]
:: /*Hello, AbleScript!*/ print;
Hello, AbleScript!
::
```

### Inside a `nix shell`

```sh
$ nix shell github:FedericoSchonborn/ablescript-nix#ablescript
[nix-shell] $ ablescript_cli
Hi [AbleScript 0.5.2]
:: /*Hello, AbleScript!*/ print;
Hello, AbleScript!
::
```

### In a Nix Flake

```nix
{
  inputs = {
    # Provides:
    #   packages.${system}.default (-> packages.${system}.ablescript)
    #   overlays.default           (-> overlays.ablescript)
    ablescript.url = "github:FedericoSchonborn/ablescript-nix";
    # ablescript.inputs.nixpkgs.url = "...";
    # ablescript.inputs.flake-utils.url = "...";
  };

  outputs = { ablescript, ... }: { ... };
}
```

### In a Nix derivation

```nix
{ lib, fetchTarball, ... }:
# Provides:
#   packages.${system}.default (-> packages.${system}.ablescript)
#   overlays.default           (-> overlays.ablescript)
let
  ablescript = fetchTarball {
    url = "https://github.com/FedericoSchonborn/ablescript-nix/archive/${commitHash}.zip";
    sha256 = lib.fakeSha256;
  };
in
{ ... }
```

## Binary cache

A binary cache is available at [`ablescript`](https://app.cachix.org/cache/ablescript).

```sh
$ cachix use ablescript
Configured https://ablescript.cachix.org binary cache in .../nix/nix.conf
```
