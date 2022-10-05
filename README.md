# AbleScript for Nix

Nix Flake for AbleScript.

## Usage

### Using `nix run`

```sh
$ nix run github:FedericoSchonborn/nix-ablescript#ablescript
Hi [AbleScript 0.5.2]
:: /*Hello, AbleScript!*/ print;
Hello, AbleScript!
::
```

### Inside a `nix shell`

```sh
$ nix shell github:FedericoSchonborn/nix-ablescript#ablescript
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
    ablescript.url = "github:FedericoSchonborn/nix-ablescript";
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
    url = "https://github.com/FedericoSchonborn/nix-ablescript/archive/${commitHash}.zip";
    sha256 = lib.fakeSha256;
  };
in
{ ... }
```
