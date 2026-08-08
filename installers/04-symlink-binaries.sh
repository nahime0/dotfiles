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

rm -rf $HOME/bin/zj
ln -s $DIR/bin/zellij-switcher $HOME/bin/zj
log_message "Created symbolic link for zellij-switcher as zj..."

rm -rf $HOME/bin/zellij-close-session
ln -s $DIR/bin/zellij-close-session $HOME/bin/zellij-close-session
log_message "Created symbolic link for zellij-close-session..."

rm -rf $HOME/bin/export-extensions
ln -s $DIR/bin/export-extensions $HOME/bin/export-extensions
log_message "Created symbolic link for export-extensions..."

rm -rf $HOME/bin/ray
ln -s $DIR/bin/ray $HOME/bin/ray
log_message "Created symbolic link for ray scripts directory..."
