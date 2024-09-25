#!/usr/bin/env zsh

#################
# Install fonts #
#################

# ComicShanns

if [ ! $OS = "macos" ]; then
    echo "Skipping fonts installation for non-macOS systems. Install the fonts manually."
    echo "Press any key to continue"
    read -k 1
else
    rm -rf $HOME/Library/Fonts/ComicShanns
    cp -r $DIR/fonts/ComicShanns $HOME/Library/Fonts/ComicShanns
    echo "Installed ComicShanns font"
    rm -rf $HOME/Library/Fonts/JetBrainsMono
    cp -r $DIR/fonts/JetBrainsMono $HOME/Library/Fonts/JetBrainsMono
    echo "Installed JetBrainsMono font"
fi
echo ""
