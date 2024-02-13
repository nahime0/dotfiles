#!/usr/bin/env zsh

################################################
# Ensure that command line tools are installed #
################################################

# Xcode command line tools
if ! xcode-select -p &> /dev/null; then
    echo ""
    echo "Xcode command line tools not found. Installing..."
    echo "Re run this script after the installation is complete."
    echo ""
    xcode-select --install
    exit 1
fi
