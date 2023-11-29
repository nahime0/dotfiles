#!/usr/bin/env zsh

##################
# Needed folders #
##################

# Ensure that $HOME/bin exists
mkdir -p $HOME/bin
$GUM style --padding "0 2" "Created $HOME/bin folder..."

# Ensure that $HOME/config exists
mkdir -p $HOME/.config
$GUM style --padding "0 2" "Created $HOME/.config folder..."
