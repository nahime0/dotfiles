#!/usr/bin/env zsh

############
# Binaries #
############

# Import shell helpers
SCRIPT_DIR="${0:A:h}"
source $SCRIPT_DIR/../lib/shell.sh

rm -rf $HOME/bin/p
ln -s $DIR/bin/project-switcher $HOME/bin/p
log_message "Created symbolic link for project-switcher..."

rm -rf $HOME/bin/ray
ln -s $DIR/bin/ray $HOME/bin/ray
log_message "Created symbolic link for ray scripts directory..."
