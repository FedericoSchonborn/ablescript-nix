# AbleScript for Nix

Nix Flake for AbleScript.

## Usage

### Using Nix Run

```sh
$ nix run github:FedericoSchonborn/nix-ablescript#ablescript
Hi [AbleScript 0.5.2]
:: /*Hello, AbleScript!*/ print;
Hello, AbleScript!
::
```

### Inside a Nix Shell

```sh
$ nix shell github:FedericoSchonborn/nix-ablescript#ablescript
[nix-shell] $ ablescript_cli
Hi [AbleScript 0.5.2]
:: /*Hello, AbleScript!*/ print;
Hello, AbleScript!
::
```

### As a Flake

```nix
{
  inputs = {
    # Provides:
    #   overlays.default (-> overlays.ablescript)
    #   packages.default (-> packages.ablescript)
    ablescript.url = "github:FedericoSchonborn/nix-ablescript";
  };
}
```
