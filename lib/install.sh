#!/usr/bin/env bash

DOTFILES_BACKUP_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups/$(date +%Y%m%d-%H%M%S)"
log() { printf '%s\n' "$*"; }
die() { printf 'error: %s\n' "$*" >&2; exit 1; }
run() {
  if [[ "$DOTFILES_APPLY" == true ]]; then "$@"; else printf '+ '; printf '%q ' "$@"; printf '\n'; fi
}
ensure_dir() {
  [[ -d "$1" ]] || run mkdir -p "$1"
}
backup_path() {
  local target=$1 relative
  [[ -e "$target" || -L "$target" ]] || return 0
  relative=${target#"$HOME"/}
  run mkdir -p "$DOTFILES_BACKUP_DIR/$(dirname -- "$relative")"
  run mv "$target" "$DOTFILES_BACKUP_DIR/$relative"
}

backup_copy_path() {
  local target=$1 relative
  [[ -e "$target" || -L "$target" ]] || return 0
  relative=${target#"$HOME"/}
  run mkdir -p "$DOTFILES_BACKUP_DIR/$(dirname -- "$relative")"
  run cp -a "$target" "$DOTFILES_BACKUP_DIR/$relative"
}

link_file() {
  local source=$1 target=$2
  [[ -e "$source" || -L "$source" ]] || die "Missing source: $source"
  if [[ -L "$target" && $(readlink "$target") == "$source" ]]; then
    log "unchanged: $target"; return
  fi
  backup_path "$target"
  ensure_dir "$(dirname -- "$target")"
  run ln -s "$source" "$target"
}
copy_file() {
  local source=$1 target=$2
  [[ -f "$source" ]] || die "Missing source: $source"
  if [[ -f "$target" && ! -L "$target" ]] && cmp -s "$source" "$target"; then
    log "unchanged: $target"; return
  fi
  backup_path "$target"
  ensure_dir "$(dirname -- "$target")"
  run cp "$source" "$target"
}
link_children() {
  local source_dir=$1 target_dir=$2 entry
  ensure_dir "$target_dir"
  shopt -s nullglob dotglob
  for entry in "$source_dir"/*; do link_file "$entry" "$target_dir/$(basename -- "$entry")"; done
  shopt -u nullglob dotglob
}

clone_git_repo() {
  local source=$1 target=$2
  if [[ -d "$target/.git" && $(git -C "$target" remote get-url origin 2>/dev/null) == "$source" ]]; then
    log "unchanged: $target"; return
  fi
  [[ "$DOTFILES_APPLY" != true ]] || command -v git >/dev/null 2>&1 || die "git is required to clone $source"
  backup_path "$target"
  ensure_dir "$(dirname -- "$target")"
  run git clone --depth 1 "$source" "$target"
}

ensure_source_line() {
  local target=$1 line=$2

  if [[ -f "$target" ]] && grep -Fxq "$line" "$target"; then
    log "unchanged: $target already loads the dotfiles shell fragment"
    return
  fi

  backup_copy_path "$target"
  ensure_dir "$(dirname -- "$target")"
  if [[ "$DOTFILES_APPLY" == true ]]; then
    printf '\n%s\n' "$line" >>"$target"
  else
    printf '+ append %q to %q\n' "$line" "$target"
  fi
}

install_mise_tools() {
  local manifest=$1 line tool version
  local -a requested=()

  while IFS= read -r line; do
    if [[ $line =~ ^\"([^\"]+)\"[[:space:]]*=[[:space:]]*\"([^\"]+)\" ]]; then
      tool=${BASH_REMATCH[1]}
      version=${BASH_REMATCH[2]}
    elif [[ $line =~ ^([A-Za-z0-9_-]+)[[:space:]]*=[[:space:]]*\"([^\"]+)\" ]]; then
      tool=${BASH_REMATCH[1]}
      version=${BASH_REMATCH[2]}
    else
      continue
    fi
    requested+=("$tool@$version")
  done <"$manifest"

  ((${#requested[@]})) || die "No tools found in $manifest"
  run mise use --global --yes "${requested[@]}"
}
