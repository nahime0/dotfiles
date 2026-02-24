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
- Neovim
- tmux

# CLI Tools

Modern CLI tools installed via Homebrew.

## File manager

| Tool | Description | Usage |
|------|-------------|-------|
| `yazi` | Blazing fast TUI file manager written in Rust, with image/PDF preview and vim keybindings | `yazi` |
| `broot` | Interactive tree navigation, great for exploring large projects | `br` |

## Modern replacements for classic tools

| Tool | Replaces | Description | Alias |
|------|----------|-------------|-------|
| `eza` | `ls` | Colors, icons, tree view | `ls`, `ll`, `lt` |
| `bat` | `cat` | Syntax highlighting, git integration | `cat` |
| `fd` | `find` | Much faster and more intuitive | `find` |
| `ripgrep` | `grep` | Extremely fast, respects .gitignore | `grep` (command: `rg`) |
| `zoxide` | `cd` | Learns your most used directories | `z folder_name` |
| `dust` | `du` | Disk space usage visualization | `du` |
| `procs` | `ps` | Readable, colorful output | `ps` |
| `sd` | `sed` | Intuitive find & replace | `sd 'old' 'new' file.txt` |

## Productivity

| Tool | Description | Usage |
|------|-------------|-------|
| `fzf` | Universal fuzzy finder, integrates with everything | `CTRL+R` (history), `CTRL+T` (files) |
| `tmux` | Terminal multiplexer | `tmux` |
| `lazygit` | TUI for git | `lazygit` |
| `lazyworktree` | TUI for git worktrees | `lazyworktree` |
| `lazydocker` | TUI for Docker | `lazydocker` |
| `tldr` | Simplified man pages with practical examples | `tldr command_name` |
| `btop` | Beautiful system monitor (replaces htop) | `btop` |

## Networking & utilities

| Tool | Replaces | Description | Usage |
|------|----------|-------------|-------|
| `httpie` | `curl` | Readable HTTP client for APIs | `http GET https://api.example.com` |
| `doggo` | `dig` | Modern DNS lookup | `doggo` |
| `gping` | `ping` | Ping with real-time graph | `gping` |

## Configured aliases

```bash
# Modern replacements
alias ls="eza --icons"
alias ll="eza -la --icons"
alias lt="eza --tree --icons"
alias cat="bat"
alias find="fd"
alias grep="rg"
alias du="dust"
alias ps="procs"
alias ping="gping"
alias dig="doggo"

# Zoxide (replaces cd)
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)
```

## Top 5 essentials

If you could only pick 5: **fzf**, **zoxide**, **eza**, **ripgrep**, **lazygit**. They completely change the way you use the terminal.

# Neovim Keybindings

| Keybinding | Action |
|------------|--------|
| `<leader>f` | Neotree (file browser) |
| `<leader>n` | Neotree reveal toggle |
| `<leader>o` | Telescope find_files |
| `<leader>O` | Telescope find_files (all files) |
| `<leader>e` | Telescope oldfiles (recent files) |
| `<leader>b` | Telescope buffers |
| `<leader>g` | Telescope live grep |
| `<leader>s` | Telescope LSP document symbols |
| `Tab` | Copilot accept |

# Credits
A lot of the `nvim` and `tmux` configuration has been influenced by
jessarcher: https://github.com/jessarcher/dotfiles
