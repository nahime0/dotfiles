#!/usr/bin/env bash
set -euo pipefail

colors_file="$HOME/.local/state/omarchy/current/theme/colors.toml"
[[ -f "$colors_file" ]] || exit 0
command -v omarchy-theme-color >/dev/null 2>&1 || exit 0
tmux list-sessions >/dev/null 2>&1 || exit 0

foreground=$(omarchy-theme-color --file "$colors_file" foreground) || exit 0
background=$(omarchy-theme-color --file "$colors_file" background) || exit 0
inactive_background=$(omarchy-theme-color --file "$colors_file" dark_background) || exit 0
[[ -n "$foreground" && -n "$background" && -n "$inactive_background" ]] || exit 0

tmux set-option -g window-style "fg=$foreground,bg=$inactive_background" \
  \; set-option -g window-active-style "fg=$foreground,bg=$background"
