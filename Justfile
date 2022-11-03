packages := "ablescript0_5_2 ablescript0_5 ablescript0_4 ablescript0_3 ablescript0_2 ablescript-unstable"

@_default:
    just --list

# Build all packages.
@build-all:
    just build {{ packages }}

# Build one or more packages.
@build +PACKAGES:
    for package in {{ PACKAGES }}; do \
        echo "Building $package..."; \
        nix build --print-build-logs ".#$package"; \
    done
