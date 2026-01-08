#!/usr/bin/env zsh

##################
# Needed folders #
##################

# Import shell helpers
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_DIR/../lib/shell.sh

# Ensure that $HOME/bin exists
mkdir -p $HOME/bin
log_message "Created $HOME/bin folder..."

# Ensure that $HOME/config exists
mkdir -p $HOME/.config
log_message "Created $HOME/.config folder..."
