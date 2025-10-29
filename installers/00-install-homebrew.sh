#!/usr/bin/env zsh

####################
# Install Homebrew #
####################

which -s brew
if [[ $? != 0 ]] ; then
    echo "Brew not found. Installing..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
    eval "$(/opt/homebrew/bin/brew shellenv)"

    exit 1
fi
