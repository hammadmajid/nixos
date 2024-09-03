#!/usr/bin/env fish

# Thanks to 0atman
# https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5

# A rebuild script that commits on a successful build
set -e

# Edit your config
hx ./nixos.nix

# cd to your config dir
pushd ~/dotfiles

# Early return if no changes were detected (thanks @singiamtel!)
if test (git diff --quiet '*.nix'; or echo $status) -eq 0
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

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackbacks
sudo nixos-rebuild switch >nixos-switch.log 2>&1; or begin
    cat nixos-switch.log | grep --color error
    exit 1
end

# Get current generation metadata
set current (nixos-rebuild list-generations | grep current)

# Commit all changes with the generation metadata
git commit -am "$current"

# Back to where you were
popd

# Notify all OK!
# notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
