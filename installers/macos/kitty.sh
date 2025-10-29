#!/usr/bin/env zsh

#########
# Kitty #
#########

# @todo Add update flag

if [ ! -d /Applications/kitty.app ]; then
    echo "Kitty not found. Installing..."

    # Launch the default kitty installer - updater (https://sw.kovidgoyal.net/kitty/binary/)
    # Use this script to install or update Kitty terminal emulator
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
fi
