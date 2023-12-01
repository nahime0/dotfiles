#!/usr/bin/env zsh

if $GUM confirm "Install ranger?" ; then
    $DIR/bin/pkgx/python/pipx install ranger-fm
    $GUM style --padding "0 2" "Installed ranger..."
fi
