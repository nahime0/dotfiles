# Dotfiles

This repository contains my dotfiles and some scripts to install them.

# Usage

Just run the setup script to install all the needed symlinks

# Set common parameters to git repo
git config user.name "Vincenzo Petrucci" && git config user.email "vincenzo.petrucci@gmail.com" && git config gpg.format ssh && git config user.signingKey ~/.ssh/vuppi.id_rsa

# Set ssh command
git config core.sshCommand "ssh -i ~/.ssh/vuppi.id_rsa -F /dev/null"

# Configuration of iterm/zsh theme:
Follow instruction on: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k

# Meta Key
On MacOS, with iterm2, remember to map the left option key to meta
Go to iterm2 preferences, profiles, keys, and select left option key to
act as +Esc

This configuration is usefull for emacs, but also for tmux:
- Meta + backspace = Delete entire word
- Meta + f = Move forward by one word
- Meta + b = Move backward by one word

# Dependencies

ripgrep -> To enable grep on neovim Telescope (pkgx install rg)
fzf -> For commands and neovim (pkgx install fzf)

# TODO

- Configure ranger
- Add fonts to dotfile
- Install Xcode command line tools
