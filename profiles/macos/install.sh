#!/usr/bin/env bash
[[ "$DOTFILES_APPLY" != true || $(uname -s) == Darwin ]] || die "The macos profile can only be installed on macOS"

link_file "$DOTFILES_ROOT/config/git/gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_ROOT/config/git/gitignore" "$HOME/.gitignore"
link_file "$DOTFILES_ROOT/config/kitty" "$HOME/.config/kitty"
link_file "$DOTFILES_ROOT/config/ghostty" "$HOME/.config/ghostty"
link_file "$DOTFILES_ROOT/config/alacritty" "$HOME/.config/alacritty"
link_file "$DOTFILES_ROOT/config/nvim" "$HOME/.config/nvim"
link_file "$DOTFILES_ROOT/config/tmux/tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_ROOT/config/tmux/themes" "$HOME/.tmux/themes"
link_file "$DOTFILES_ROOT/config/tmux/scripts" "$HOME/.tmux/scripts"
link_file "$DOTFILES_ROOT/config/zsh/zshenv" "$HOME/.zshenv"
link_file "$DOTFILES_ROOT/config/zsh/zprofile" "$HOME/.zprofile"
link_file "$DOTFILES_ROOT/config/zsh/p10k.zsh" "$HOME/.zsh/p10k.zsh"
link_file "$DOTFILES_ROOT/config/zsh/p10k-overrides.zsh" "$HOME/.zsh/p10k-overrides.zsh"

# ~/.zshrc stays a local file: installers such as Herd, bun or broot append to
# it, and a symbolic link would send those lines into the tracked configuration.
zshrc_source_line="source \"$DOTFILES_ROOT/config/zsh/zshrc\""

# A repository that moved leaves a source line pointing at the old path behind.
# ensure_source_line would append the new one and keep the broken one above it,
# failing on every shell start. Rewrite it in place instead of appending: the
# position matters, because everything installers add below has to keep loading
# after the dotfiles configuration, not before it.
repoint_zshrc_source() {
  local target=$1 keep=$2 stale

  [[ -f "$target" && ! -L "$target" ]] || return 0
  stale=$(grep -E '^source ".*/config/zsh/zshrc"$' "$target" | grep -vxF "$keep" || true)
  [[ -n "$stale" ]] || return 0

  log "Repointing dotfiles source line in $target, was:"
  printf '%s\n' "$stale" | sed 's/^/  /'
  [[ "$DOTFILES_APPLY" == true ]] || return 0

  backup_copy_path "$target"
  awk -v keep="$keep" '
    $0 ~ /^source ".*\/config\/zsh\/zshrc"$/ {
      if (!seen) { print keep; seen = 1 }
      next
    }
    { print }
  ' "$target" >"$target.dotfiles-tmp"
  mv "$target.dotfiles-tmp" "$target"
}

[[ ! -L "$HOME/.zshrc" ]] || backup_path "$HOME/.zshrc"
repoint_zshrc_source "$HOME/.zshrc" "$zshrc_source_line"
ensure_source_line "$HOME/.zshrc" "$zshrc_source_line"

link_file "$DOTFILES_ROOT/config/aerospace" "$HOME/.config/aerospace"
link_file "$DOTFILES_ROOT/config/hammerspoon" "$HOME/.hammerspoon"
link_file "$DOTFILES_ROOT/config/phpactor" "$HOME/.config/phpactor"
link_file "$DOTFILES_ROOT/config/micro" "$HOME/.config/micro"
link_file "$DOTFILES_ROOT/config/ideavim/ideavimrc" "$HOME/.ideavimrc"
link_file "$DOTFILES_ROOT/config/emacs/emacs.d" "$HOME/.emacs.d"
link_file "$DOTFILES_ROOT/config/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
link_file "$DOTFILES_ROOT/config/cursor/keybindings.json" "$HOME/Library/Application Support/Cursor/User/keybindings.json"
link_file "$DOTFILES_ROOT/config/code/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
link_file "$DOTFILES_ROOT/config/code/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

link_file "$DOTFILES_ROOT/quotes/quotes.txt" "$HOME/.quotes.txt"
link_file "$DOTFILES_ROOT/bin/project-switcher" "$HOME/bin/p"
link_file "$DOTFILES_ROOT/bin/ray" "$HOME/bin/ray"
link_file "$DOTFILES_ROOT/bin/tailscale-config" "$HOME/bin/tailscale-config"
