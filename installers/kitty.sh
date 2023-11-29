#!/usr/bin/env zsh

#########
# Kitty #
#########

if [ ! -d /Applications/kitty.app ]; then
    if $GUM confirm "Do you want to install Kitty?" ; then
        $GUM style --padding "0 2" "Installing Kitty..."
        $GUM style --padding "0 2" "Re run this script after the installation is complete."
        $GUM style --padding "0 2" "Press a key to continue..."
        read -n 1
        exec $DIR/setup-kitty
        exit 1
    fi
fi
