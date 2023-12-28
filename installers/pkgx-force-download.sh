#!/usr/bin/env zsh

##################################################
# Force download of needed libraries             #
# Just run the command and pkgx will do the rest #
##################################################

if $GUM confirm "Do you want to force the download of pkgx binaries?" ; then
    $GUM style --padding "0 2" "Downloading pkgx binaries, and printing version..."

    echo "git: $(~/bin/git --version)" | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    echo "php: $(~/bin/php --version)" | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    echo "composer: $(~/bin/composer --version)" | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    echo "ripgrep: $(~/bin/rg --version)" | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    echo "fzf: $(~/bin/fzf --version)" | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    echo "node: $(~/bin/node --version)" | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    echo "npm: $(~/bin/npm --version)" | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60
fi
