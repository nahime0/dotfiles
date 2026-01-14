#!/usr/bin/env zsh

#######################################
# Install oh-my-zsh, if not installed #
#######################################

# Import shell helpers
SCRIPT_DIR="${0:A:h}"
source $SCRIPT_DIR/../lib/shell.sh

if [ ! -d $HOME/.oh-my-zsh ]; then
    log_message "Installing oh-my-zsh..."
    log_message "Exit with CTRL+D when the omz prompt is ready to return to the installer."
    wait_for_key
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

###############################
# Install powerlevel10k theme #
###############################
if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi
