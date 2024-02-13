#!/usr/bin/env zsh

############
# Homebrew #
############

if [ ! -d $HOME/.brew ]; then
    if $GUM confirm "Do you want to install Homebrew?" ; then

        $GUM style --padding "0 2" "Installing Homebrew..."
        mkdir $HOME/.brew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $HOME/.brew

        exit 1
    fi
fi
