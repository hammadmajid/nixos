# dotfiles

My dotfiles for Arch Linux (btw) with KDE DE. This document is written for my future self so it will be missing a lot things that you expect from 'normal' documentaion.

## Package list

Here is not so comprehensive list of tools I use use and their arch/aur package names

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
zed
git
gh
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

Some packages requrire additional configuration, here is how to set them up.

### Kanata

Prefer creating a system-wide config instead of dealing with permissions.

- See discussion [#130](https://github.com/jtroo/kanata/discussions/130#discussioncomment-8518832)
- Also see the [wiki](https://github.com/jtroo/kanata/wiki/Avoid-using-sudo-on-Linux)

---

If you are a malicious actor looking for leaked secrets, you might be interested to know that I've committed my public SSH key, which I use sign my commit message. Feel free to check it out.
