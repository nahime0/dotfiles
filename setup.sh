#!/usr/bin/env bash

source ./functions.sh

parse_env_file .env

# Backup configuration files
if [ -f "$HOME/.ssh/config" ] && [ ! -L "$HOME/.ssh/config" ]; then
  log_string "Backing up ssh config file"
  mv "$HOME/.ssh/config" "$HOME/.ssh/config.bak"
fi

# Symlinking configuration files from this repo

# VIM
if [ ! -L "$HOME/.vimrc" ]; then
  log_string "Symlinking vim config file"
  ln -s "$(pwd)/vim/vimrc" "$HOME/.vimrc"
else
  log_string "Symbolink link for vim config file already exists"
fi

# IdeaVIM
if [ ! -L "$HOME/.ideavimrc" ]; then
  log_string "Symlinking ideavim config file"
  ln -s "$(pwd)/vim/ideavimrc" "$HOME/.ideavimrc"
else
  log_string "Symbolink link for ideavim config file already exists"
fi

# SSH
if [ ! -L "$HOME/.ssh/config" ]; then
  log_string "Symlinking ssh config file"
  ln -s "$(pwd)/ssh/config.conf" "$HOME/.ssh/config"
else
  log_string "Symbolink link for SSH file already exists"
fi

# Git
if [ ! -L "$HOME/.gitconfig" ]; then
  log_string "Symlinking git config files"
  ln -s "$(pwd)/git/gitconfig" "$HOME/.gitconfig"
  ln -s "$(pwd)/git/gitconfig-netsons" "$HOME/.gitconfig-netsons"
  ln -s "$(pwd)/git/gitconfig-vuppi" "$HOME/.gitconfig-vuppi"
else
  log_string "Symbolink link for git file already exists"
fi

# ZSH
if [ ! -L "$HOME/.zprofile-custom" ]; then
  log_string "Symlinking custom zprofile config file"
  ln -s "$(pwd)/zsh/zprofile-custom" "$HOME/.zprofile-custom"
else
  log_string "Symbolink link for custom zprofile file already exists"
fi

# Tmux

if [ ! -L "$HOME/.tmux.conf" ]; then
  log_string "Symlinking tmux config file"
  ln -s "$(pwd)/tmux/tmux.conf" "$HOME/.tmux.conf"
else
  log_string "Symbolink link for tmux file already exists"
fi
if [ ! -L "$HOME/.tmux" ]; then
  log_string "Symlinking tmux config directory"
  ln -s "$(pwd)/tmux/tmux" "$HOME/.tmux"
else
  log_string "Symbolink link for tmux config directory already exists"
fi

# Emacs
## Step 1 backup existing folder, if exists

if [ -d "$HOME/.emacs.d" ] && [ ! -L "$HOME/.emacs.d" ]; then
  log_string "Backing up emacs config directory"
  mv "$HOME/.emacs.d" "$HOME/.emacs.d.bak"
fi

## Step 2 create symlink

if [ ! -L "$HOME/.emacs.d" ]; then
  log_string "Symlinking emacs config directory"
  ln -s "$(pwd)/emacs/emacs.d" "$HOME/.emacs.d"
else
  log_string "Symbolink link for emacs config directory already exists"
fi

# PHPactor
rm -rf "$HOME/config/.phpactor"
ln -s "${pwd}/phpactor" "$HOME/.config/phpactor"
