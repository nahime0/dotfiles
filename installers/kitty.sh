#!/usr/bin/env zsh

#########
# Kitty #
#########

if [ ! -d /Applications/kitty.app ]; then
    $GUM style --padding "0 2" "Installing Kitty..."
    $GUM style --padding "0 2" "Re run this script after the installation is complete."
    $GUM style --padding "0 2" "Press a key to continue..."
    read -n 1

    # Launch the default kitty installer - updater (https://sw.kovidgoyal.net/kitty/binary/)
    # Use this script to install or update Kitty terminal emulator
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
fi
