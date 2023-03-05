#!/usr/bin/env bash

source ./functions.sh

parse_env_file .env

# Backup configuration files
if [ -f "$HOME/.ssh/config" ] && [ ! -L "$HOME/.ssh/config" ]; then
    log_string "Backing up ssh config file"
    mv "$HOME/.ssh/config" "$HOME/.ssh/config.bak"
fi

# Symlinking configuration files from this repo
if [ ! -L "$HOME/.ssh/config" ]; then
    if [ -f "$HOME/$ALTERNATIVE_SSH_KEY_FILE" ]; then
        log_string "Symlinking alternative ssh config file"
        ln -s "$(pwd)/ssh/config.alternative.conf" "$HOME/.ssh/config"
    else
        log_string "Symlinking regular ssh config file"
        ln -s "$(pwd)/ssh/config.conf" "$HOME/.ssh/config"
    fi
else
    log_string "Symbolink link for SSH file already exists"
fi
