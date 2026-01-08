#!/usr/bin/env zsh

##############################
# Sync editor extensions     #
##############################

# Import shell helpers
SCRIPT_DIR="${0:A:h}"
source $SCRIPT_DIR/../lib/shell.sh

# Function to sync extensions for an editor
# Usage: sync_extensions <editor_cmd> <extensions_file> <editor_name>
sync_extensions() {
    local editor_cmd=$1
    local extensions_file=$2
    local editor_name=$3
    
    if ! command -v $editor_cmd &> /dev/null; then
        log_message "$editor_name CLI not found. Skipping."
        return
    fi
    
    if [ ! -f "$extensions_file" ]; then
        log_message "$editor_name extensions file not found."
        return
    fi
    
    log_message "Syncing $editor_name extensions..."
    
    # Get currently installed extensions (lowercase for comparison)
    local installed=()
    while IFS= read -r ext; do
        installed+=("${ext:l}")
    done < <($editor_cmd --list-extensions 2>/dev/null)
    
    # Get desired extensions from file (lowercase for comparison)
    local desired=()
    while IFS= read -r ext || [ -n "$ext" ]; do
        if [ -n "$ext" ]; then
            desired+=("${ext:l}")
        fi
    done < "$extensions_file"
    
    # Install missing extensions
    local to_install=()
    for ext in "${desired[@]}"; do
        if [[ ! " ${installed[*]} " =~ " ${ext} " ]]; then
            to_install+=("$ext")
        fi
    done
    
    if [ ${#to_install[@]} -gt 0 ]; then
        log_message "Installing ${#to_install[@]} extensions..."
        for ext in "${to_install[@]}"; do
            $editor_cmd --install-extension "$ext" --force 2>/dev/null
        done
    fi
    
    # Remove extra extensions
    local to_remove=()
    for ext in "${installed[@]}"; do
        if [[ ! " ${desired[*]} " =~ " ${ext} " ]]; then
            to_remove+=("$ext")
        fi
    done
    
    if [ ${#to_remove[@]} -gt 0 ]; then
        log_message "Removing ${#to_remove[@]} extensions..."
        for ext in "${to_remove[@]}"; do
            $editor_cmd --uninstall-extension "$ext" 2>/dev/null
        done
    fi
    
    log_message "$editor_name extensions synced."
}

# Sync Cursor extensions
sync_extensions "cursor" "$SCRIPT_DIR/../config/cursor/extensions.txt" "Cursor"

# Sync VS Code extensions
sync_extensions "code" "$SCRIPT_DIR/../config/code/extensions.txt" "VS Code"
