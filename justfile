# just is a command runner, Justfile is very similar to Makefile, but simpler.
# see: https://nixos-and-flakes.thiscute.world/best-practices/simplify-nixos-related-commands

# rebuild the system
build:
  sudo nixos-rebuild switch --flake .

# debug nixos-rebuild
debug:
  sudo nixos-rebuild switch --flake . --show-trace --verbose

# update everything
up:
  nix flake update

# Update specific input
# usage: make upp i=home-manager
upp:
  nix flake update $(i)

# remove all generations older than 7 days
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# garbage collect all unused nix store entries
gc:
  sudo nix-collect-garbage --delete-old

# format .nix files with alejandra
format:
  alejandra .

# Check if flake is valid
check:
  nix flake check --keep-going
