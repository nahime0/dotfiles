#!/usr/bin/env zsh

####################
# Install Homebrew #
####################

if [ ! -d $HOME/.brew ]; then
    echo "Brew not found. Installing..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    exit 1
fi
