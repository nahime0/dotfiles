#!/usr/bin/env zsh

################
# Install pkgx #
################

if [ ! -f /usr/local/bin/pkgx ]; then
    echo "pkgx not found. Installing..."
    echo "Re run this script after the installation is complete."
    echo "Press a key to continue..."
    read -n 1
    curl -Ssf https://pkgx.sh | sh
    exit 1
fi
