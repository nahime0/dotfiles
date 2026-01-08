#!/usr/bin/env zsh

#######################################
# Install oh-my-zsh, if not installed #
#######################################

# Import shell helpers
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_DIR/../lib/shell.sh

if [ ! -d $HOME/.oh-my-zsh ]; then
    log_message "Installing oh-my-zsh..."
    log_message "Re run this script after the installation is complete."
    wait_for_key
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    exit 1
fi

###############################
# Install powerlevel10k theme #
###############################
if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi
