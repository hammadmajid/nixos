# Manage NixOS

The code blocks inside this markdown file can be executed with [mask](https://github.com/jacobdeichert/mask). The Nix package is called `mask`, and you can install it however you prefer.

Thanks to @0atman for the original script. You can find his script in the [gist](https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5) he published. Also, I recommend checking out his [YouTube channel](https://www.youtube.com/@NoBoilerplate).

## setup

This script will move the `configuration.nix` file to the `/etc/nixos/` directory. It will back up any existing configuration.nix file by renaming it with a timestamp and replace it with the new `configuration.nix` file.

> Replace /etc/nixos/configuration.nix with ./configuration.nix

~~~bash
#!/bin/bash

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Backup the existing configuration file
sudo mv "/etc/nixos/configuration.nix" "/etc/nixos/configuration-$timestamp.nix.bak" || { echo "Backup failed"; exit 1; }

# Copy the new configuration file
sudo cp "./configuration.nix" "/etc/nixos/configuration.nix" || { echo "Copy failed"; exit 1; }
~~~

## edit

This will open your default `$EDITOR`, and once you close the editor, [alejandra](https://github.com/kamadorueda/alejandra) will format the code (requires the `alejandra` package). If no changes are detected, the script will gracefully exit.

> Open the default editor, and then format the code after it’s closed.

~~~bash
$EDITOR main.nix

if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    exit 0
fi

alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

git diff -U0 '*.nix'
~~~

## build

This will rebuild NixOS and commit the changes you made with a message containing the current generation's metadata.

> Build NixOS & commit the changes 

~~~bash
set -e # exit in case of error

sudo nixos-rebuild switch

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

git commit -am "$current"
~~~

## cleanup

To free up space and remove old generations and store paths, you can run the NixOS garbage collector. This will delete all generations and store paths older than the specified amount.

> Run the NixOS garbage collector to clean up unused store paths

**OPTIONS**
* days
  * flags: -d --days
  * type: number
  * desc: delete all generations older than the specified amount
  * required

~~~bash
set -e 

echo "Deleting generations older than ${days} days"

sudo nix-collect-garbage --delete-older-than "${days}d"
~~~
