#!/usr/bin/env bash

install_desktop() {
  local desktop="$DOTFILES_ROOT/profiles/omarchy/desktop"
  local config_home="${XDG_CONFIG_HOME:-$HOME/.config}" name
  [[ "$DOTFILES_APPLY" != true ]] || command -v python3 >/dev/null || die "python3 is required"
  # Preview and validate the merge before switching any managed links.
  python3 "$desktop/configure.py"
  for name in wide-layout.lua herdr-clipboard.lua rustdesk-shortcuts.lua workspace-layout-cycle; do
    link_file "$desktop/hypr/$name" "$config_home/hypr/$name"
  done
  link_file "$desktop/hypr" "$config_home/hypr/dotfiles"
  link_file "$desktop/plugins/nahime.workspaces" "$config_home/omarchy/plugins/nahime.workspaces"
  if [[ "$DOTFILES_APPLY" == true && -n ${HYPRLAND_INSTANCE_SIGNATURE:-} ]] && command -v omarchy-shell >/dev/null; then
    omarchy-shell shell rescanPlugins >/dev/null
  fi
  local -a options=()
  [[ "$DOTFILES_APPLY" != true ]] || options+=(--apply)
  python3 "$desktop/configure.py" "${options[@]}"
  if [[ "$DOTFILES_APPLY" == true ]] && command -v hyprctl >/dev/null && [[ -n ${HYPRLAND_INSTANCE_SIGNATURE:-} ]]; then
    hyprctl reload
    local errors
    errors=$(hyprctl configerrors)
    [[ -z ${errors//[[:space:]]/} ]] || die "Hyprland configuration errors: $errors"
  fi
}
