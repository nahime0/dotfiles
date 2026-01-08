#!/usr/bin/env zsh

##############################
# Install editor extensions  #
##############################

# Import shell helpers
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_DIR/../lib/shell.sh

# Install Cursor extensions
if command -v cursor &> /dev/null; then
    log_message "Installing Cursor extensions..."
    CURSOR_EXTENSIONS_FILE="$SCRIPT_DIR/../config/cursor/extensions.txt"
    if [ -f "$CURSOR_EXTENSIONS_FILE" ]; then
        while IFS= read -r extension || [ -n "$extension" ]; do
            if [ -n "$extension" ]; then
                cursor --install-extension "$extension" --force 2>/dev/null
            fi
        done < "$CURSOR_EXTENSIONS_FILE"
        log_message "Cursor extensions installed."
    else
        log_message "Cursor extensions file not found."
    fi
else
    log_message "Cursor CLI not found. Skipping Cursor extensions."
fi

# Install VS Code extensions
if command -v code &> /dev/null; then
    log_message "Installing VS Code extensions..."
    CODE_EXTENSIONS_FILE="$SCRIPT_DIR/../config/code/extensions.txt"
    if [ -f "$CODE_EXTENSIONS_FILE" ]; then
        while IFS= read -r extension || [ -n "$extension" ]; do
            if [ -n "$extension" ]; then
                code --install-extension "$extension" --force 2>/dev/null
            fi
        done < "$CODE_EXTENSIONS_FILE"
        log_message "VS Code extensions installed."
    else
        log_message "VS Code extensions file not found."
    fi
else
    log_message "VS Code CLI not found. Skipping VS Code extensions."
fi
