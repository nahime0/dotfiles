#!/usr/bin/env bash

source ./functions.sh

parse_env_file .env

# Backup configuration files
if [ -f "$HOME/.ssh/config" ] && [ ! -L "$HOME/.ssh/config" ]; then
  log_string "Backing up ssh config file"
  mv "$HOME/.ssh/config" "$HOME/.ssh/config.bak"
fi

# Symlinking configuration files from this repo

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
  ln -s "$(pwd)/git/gitconfig-athomos" "$HOME/.gitconfig-athomos"
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
