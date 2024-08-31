# dotfiles

![image](https://github.com/user-attachments/assets/116486bb-1c9e-4b60-9a39-189b74b73a71)

My dotfiles for Arch Linux (btw) with Cosmic DE.

## Package list

Here is not so comprehensive list of tools I use use and their arch/aur package names:

```
helix
zoxide
starship
mise
zellij
sccache
fish
exa
alacritty
lazygit
git
gh
atuin
bottom
```

## Ignored

Ignore directories and files in `.git/info/exclude` file so I don't have to track my git ignores. Here is a little sample of it:

```gitignore
.cache
.local
.mozilla
.shh # Must ignore this
Desktop
Documents
Downloads
Music
Pictures
Public
Templates
Videos
# ... and so on
```

## Additional config

Some packages requrire additional configuration that can't be tracked.

### Kanata

Map the `caps lock` key to `esc` when pressed and to `ctrl` when held. See `.config/kanata`.

Prefer creating a system-wide config instead of dealing with permissions.

- See discussion [#130](https://github.com/jtroo/kanata/discussions/130#discussioncomment-8518832)
- Also see the [wiki](https://github.com/jtroo/kanata/wiki/Avoid-using-sudo-on-Linux)

### Helix

Install LSPs with:

```sh
sudo npm i -g vscode-langservers-extracted svelte-language-server @tailwindcss/language-server typescript-svelte-plugin @astrojs/language-server typescript typescript-language-server
```

Checkout the [Helix Wiki](https://github.com/helix-editor/helix/wiki/Language-Server-Configurations) for more information.
