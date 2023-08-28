#!/usr/bin/env bash
# Desc: Clear all the symbolic links

source ./functions.sh
parse_env_file .env


# VIM
if [ -L "$HOME/.vimrc" ]; then
  log_string "Removing symbolic link for vim config file"
  rm -rf "$HOME/.vimrc"
fi

# IdeaVIM
if [ -L "$HOME/.ideavimrc" ]; then
  log_string "Removing symbolic link for ideavim config file"
  rm -rf "$HOME/.ideavimrc"
fi

# SSH
if [ -L "$HOME/.ssh/config" ]; then
  log_string "Removing symbolic link for SSH file"
  rm -rf "$HOME/.ssh/config"
fi

# Git
if [ -L "$HOME/.gitconfig" ]; then
  log_string "Removing symbolic link for git file"
  rm -rf "$HOME/.gitconfig"
fi

if [ -L "$HOME/.gitconfig-athomos" ]; then
  log_string "Removing symbolic link for git file (athomos)"
  rm -rf "$HOME/.gitconfig-athomos"
fi

if [ -L "$HOME/.gitconfig-vuppi" ]; then
  log_string "Removing symbolic link for git file (vuppi)"
  rm -rf "$HOME/.gitconfig-vuppi"
fi

# ZSH
if [ -L "$HOME/.zprofile-custom" ]; then
  log_string "Removing symbolic link for custom zprofile file"
  rm -rf "$HOME/.zprofile-custom"
fi


# Tmux
if [ -L "$HOME/.tmux.conf" ]; then
  log_string "Removing symbolic link for tmux config file"
  rm -rf "$HOME/.tmux.conf"
fi

if [ -L "$HOME/.tmux" ]; then
  log_string "Removing symbolic link for tmux config directory"
  rm -rf "$HOME/.tmux"
fi


