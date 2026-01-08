#!/usr/bin/env zsh

############
# Binaries #
############

# Import shell helpers
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_DIR/../lib/shell.sh

rm -rf $HOME/bin/p
ln -s $DIR/bin/project-switcher $HOME/bin/p
log_message "Created symbolic link for project-switcher..."

rm -rf $HOME/bin/export-extensions
ln -s $DIR/bin/export-extensions $HOME/bin/export-extensions
log_message "Created symbolic link for export-extensions..."
