# Dotfiles 

This repository contains my dotfiles and some scripts to install them.

# Usage

Just run the setup script to install all the needed symlinks

On MacOS, install the xcode command line tools first:

```bash
xcode-select --install
```

Then run the setup script:

```bash
./setup.sh
```

# Warnings

This setup will delete configuration files and replace them with a symlink to
the files in this repository.

Launch this at your own risk.

# Private stuff
The installer in this repository will check for the existance of a file setup
in the folder `dotfiles-private`.

If the file is found, it will be launched. You can use the `dotfiles-private`
folder to store personal configuration (i.e. ssh and so on).

# Git

The idenity for git commits will be included from the `~/.gitidentity` file.
The file should include the `[user]` section of the git configuration file.

For example:

```gitconfig
[user]
    name = My name
    email = my@email.com
    signingKey = ~/.ssh/id_rsa
```

You can create the `~/.gitidentity` file using the dotfiles-private folder described above.

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
- micro (pkgx shim)
- Ranger (via pipx)

# Neovim Keybindings

| Keybinding | Funzione |
|------------|----------|
| `<leader>f` | Neotree (file browser) |
| `<leader>n` | Neotree reveal toggle |
| `<leader>o` | Telescope find_files |
| `<leader>O` | Telescope find_files (tutti i file) |
| `<leader>e` | Telescope oldfiles (file recenti) |
| `<leader>b` | Telescope buffers |
| `<leader>g` | Telescope live grep |
| `<leader>s` | Telescope LSP document symbols |
| `Tab` | Copilot accept |

# Credits
A lot of the `nvim` and `tmux` configuration has been influenced by
jessarcher: https://github.com/jessarcher/dotfiles
