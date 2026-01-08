# Log a message using gum if available, otherwise echo
function log_message() {
    local message="$1"
    if command -v gum &> /dev/null; then
        gum style --padding "0 2" "$message"
    else
        echo "  $message"
    fi
}

# Show a styled header using gum if available, otherwise echo
function log_header() {
    local message="$1"
    if command -v gum &> /dev/null; then
        gum style --border normal --padding "0 4" --border-foreground 212 "$message"
    else
        echo ""
        echo "=== $message ==="
        echo ""
    fi
}

# Show a confirmation prompt using gum if available, otherwise read
function confirm_prompt() {
    local message="$1"
    if command -v gum &> /dev/null; then
        gum confirm "$message"
        return $?
    else
        read -p "$message (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            return 0
        else
            return 1
        fi
    fi
}

# Wait for user to press a key
function wait_for_key() {
    local message="${1:-Press a key to continue...}"
    if command -v gum &> /dev/null; then
        gum style --padding "0 2" "$message"
    else
        echo "  $message"
    fi
    read -k 1
}
