#!/usr/bin/env fish

# Thanks to 0atman
# https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5

# A rebuild script that commits on a successful build

# Edit your config
$EDITOR

# cd to your config dir
pushd ~/nixos

# Early return if no changes were detected (thanks @singiamtel!)
if test (git diff --quiet '*.nix'; echo $status) -eq 0
    echo "No changes detected, exiting."
    popd
    exit 0
end

# Autoformat your nix files
alejandra . >/dev/null 2>&1; or begin
    alejandra .
    echo "Formatting failed!"
    exit 1
end

# Shows your changes
git diff -U0 '*.nix'

# Rebuild NixOS
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch

# Get current generation metadata
set current (nixos-rebuild list-generations | grep current)

# Commit all changes with the generation metadata
git commit -am "$current"

# Back to where you were
popd
