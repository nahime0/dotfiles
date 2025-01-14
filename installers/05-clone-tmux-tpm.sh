#!/usr/bin/env zsh

# Check if .tmux folder does not exists, in case clone the tmux plugin manager
if [ ! -d $HOME/.tmux/plugins/tpm ]; then
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi;
