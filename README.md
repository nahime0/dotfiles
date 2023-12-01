# Dotfiles

This repository contains my dotfiles and some scripts to install them.

# Usage

Just run the setup script to install all the needed symlinks

# Warnings

This setup will delete configuration files and replace them with a symlink to
the files in this repository.

Launch this at your own risk.

# Private stuff
The installer in this repository will check for the existance of a file setup
in the folder `dotfiles-private`.

If the file is found, it will be launched. You can use the `dotfiles-private`
folder to store personal configuration (i.e. git, ssh and so on).

# What software and libraries ecc. will be installed?

- ComicShanns font
- oh-my-zsh
- Kitty
- pkgx
- bun (pkgx shim)
- composer (pkgx shim)
- fzf (pkgx shim)
- git (pkgx shim)
- gum (pkgx shim)
- mailpit (pkgx shim)
- Neovim (pkgx shim)
- node & npm (pkgx shim)
- php (pkgx shim)
- python, pip & pipx (pkgx shim)
- ripgrep (pkgx shim)
- tmux (pkgx shim)
- youtube-dl (pkgx shim)
- Ranger (via pipx)

# Credits
A lot of the `nvim` and `tmux` configuration has been influenced by
jessarcher: https://github.com/jessarcher/dotfiles
