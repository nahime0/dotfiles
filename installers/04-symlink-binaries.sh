#!/usr/bin/env zsh

############
# Binaries #
############

rm -rf $HOME/bin/p
ln -s $DIR/bin/project-switcher $HOME/bin/p
gum style --padding "0 2" "Created symbolic link for project-switcher..."
