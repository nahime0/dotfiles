#!/usr/bin/env zsh

#######################################
# Install oh-my-zsh, if not installed #
#######################################

if [ ! -d $HOME/.oh-my-zsh ]; then
    gum style --padding "0 2" "Installing oh-my-zsh..."
    gum style --padding "0 2" "Re run this script after the installation is complete."
    gum style --padding "0 2" "Press a key to continue..."
    read -k 1
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    exit 1
fi

###############################
# Install powerlevel10k theme #
###############################
if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi
