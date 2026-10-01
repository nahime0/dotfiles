#!/usr/bin/env bash
# Put the local Wayland and X11 display back into tmux.
#
# tmux update-environment copies DISPLAY, WAYLAND_DISPLAY and the XDG session
# variables from the attaching client. A client that does not have them, such
# as a pane that was itself started without a display, makes tmux remove them
# from the session (show-environment prints -NAME). New panes then have no
# display, and xdg-open runs $BROWSER instead of Nautilus.
#
# Passing a session name or id repairs that session. With no arguments, every
# current session is repaired. The global environment is updated as well so a
# session that never stored these names can inherit them.
set -euo pipefail

command -v tmux >/dev/null 2>&1 || exit 0
tmux list-sessions >/dev/null 2>&1 || exit 0

runtime="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
wayland=""
if [[ -d "$runtime" ]]; then
  for sock in "$runtime"/wayland-*; do
    [[ -S "$sock" ]] || continue
    wayland="${sock##*/}"
    break
  done
fi
[[ -n "$wayland" ]] || exit 0

display=""
if [[ -S /tmp/.X11-unix/X0 ]]; then
  display=":0"
fi

desktop=""
session_desktop=""
if [[ -d "$runtime/hypr" ]]; then
  desktop="Hyprland"
  session_desktop="Hyprland"
fi

# Print success (0) when the session value should be replaced.
needs_value() {
  local line="$1" name="$2" mode="$3"
  [[ -z "$line" || "$line" == "-$name" || "$line" == "$name=" ]] && return 0
  if [[ "$mode" == tty && "$line" == "$name=tty" ]]; then
    return 0
  fi
  return 1
}

assign() {
  local target="$1" name="$2" value="$3" mode="${4:-empty}"
  [[ -n "$value" ]] || return 0
  local line
  line="$(tmux show-environment -t "$target" "$name" 2>/dev/null || true)"
  needs_value "$line" "$name" "$mode" || return 0
  tmux set-environment -t "$target" "$name" "$value"
}

assign_global() {
  local name="$1" value="$2" mode="${3:-empty}"
  [[ -n "$value" ]] || return 0
  local line
  line="$(tmux show-environment -g "$name" 2>/dev/null || true)"
  needs_value "$line" "$name" "$mode" || return 0
  tmux set-environment -g "$name" "$value"
}

repair() {
  local target="$1"
  assign "$target" WAYLAND_DISPLAY "$wayland"
  assign "$target" DISPLAY "$display"
  assign "$target" XDG_CURRENT_DESKTOP "$desktop"
  assign "$target" XDG_SESSION_DESKTOP "$session_desktop"
  assign "$target" XDG_SESSION_TYPE wayland tty
}

if [[ $# -gt 0 ]]; then
  repair "$1"
else
  while IFS= read -r session; do
    [[ -n "$session" ]] || continue
    repair "$session"
  done < <(tmux list-sessions -F '#{session_id}')
fi

assign_global WAYLAND_DISPLAY "$wayland"
assign_global DISPLAY "$display"
assign_global XDG_CURRENT_DESKTOP "$desktop"
assign_global XDG_SESSION_DESKTOP "$session_desktop"
assign_global XDG_SESSION_TYPE wayland tty
