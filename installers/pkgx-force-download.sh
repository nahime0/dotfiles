#!/usr/bin/env zsh

##################################################
# Force download of needed libraries             #
# Just run the command and pkgx will do the rest #
##################################################

if $GUM confirm "Do you want to force the download of pkgx binaries?" ; then
    $GUM style --padding "0 2" "Downloading pkgx binaries, and printing version..."
    {
        $GUM style --foreground 212 "The installed version of Git is:";
        ~/bin/git --version
    } | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    {
        $GUM style --foreground 212 "The installed version of PHP is:";
        ~/bin/php --version
    } | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    {
        $GUM style --foreground 212 "The installed version of Composer is:";
        ~/bin/composer --version
    } | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    {
        $GUM style --foreground 212 "The installed version of Ripgrep is:";
        ~/bin/rg --version
    } | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    {
        $GUM style --foreground 212 "The installed version of fzf is:";
        ~/bin/fzf --version
    } | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    {
        $GUM style --foreground 212 "The installed version of node is:";
        ~/bin/node --version
    } | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60

    {
        $GUM style --foreground 212 "The installed version of npm is:";
        ~/bin/npm --version
    } | $GUM style --border normal --padding "0 4" --border-foreground 212 --width 60
fi
