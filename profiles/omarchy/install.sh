#!/usr/bin/env bash
[[ "$DOTFILES_APPLY" != true || $(uname -s) == Linux ]] || die "The omarchy profile requires Linux"
[[ "$DOTFILES_APPLY" != true ]] || command -v omarchy >/dev/null 2>&1 || die "The omarchy command was not found"
[[ "$DOTFILES_APPLY" != true ]] || command -v fc-cache >/dev/null 2>&1 || die "fc-cache is required to install fonts"

install_cursor_extension() {
  local extension=$1
  command -v cursor >/dev/null 2>&1 || return
  [[ "$extension" =~ ^[a-zA-Z0-9._-]+$ ]] || return
  cursor --list-extensions 2>/dev/null | grep -Fxiq "$extension" || run cursor --install-extension "$extension"
}

install_cursor_settings() {
  local source=$1 target=$2 descriptor generated theme="" extension="" escaped
  descriptor="$HOME/.local/state/omarchy/current/theme/vscode.json"
  generated="$HOME/.local/state/omarchy/current/theme/vscode-theme.json"

  if [[ -f "$target" ]]; then
    theme=$(sed -nE 's/.*"workbench\.colorTheme"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/p' "$target" | head -n 1) || true
  fi
  if [[ -z "$theme" && -f "$descriptor" ]]; then
    theme=$(sed -nE 's/.*"name"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/p' "$descriptor" | head -n 1) || true
  fi
  if [[ -f "$descriptor" ]]; then
    extension=$(sed -nE 's/.*"extension"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/p' "$descriptor" | head -n 1) || true
  fi
  if [[ -z "$theme" && -f "$generated" ]]; then
    theme="Omarchy"
  fi
  [[ "$theme" != *\\* ]] || theme=""

  install_cursor_extension "vscodevim.vim"
  install_cursor_extension "$extension"
  install_cursor_extension "IllegalStudio.nord-light-theme"

  copy_file "$source" "$target"
  [[ -n "$theme" ]] || return

  escaped=${theme//&/\\&}
  escaped=${escaped//|/\\|}
  if [[ "$DOTFILES_APPLY" == true ]]; then
    sed -i -E "s|(\"workbench\.colorTheme\"[[:space:]]*:[[:space:]]*\")[^\"]*(\")|\1$escaped\2|" "$target"
  else
    printf '+ preserve Cursor colour theme %q in %q\n' "$theme" "$target"
  fi
}

link_children "$DOTFILES_ROOT/fonts/ComicShanns" "$HOME/.local/share/fonts/ComicShanns"
link_children "$DOTFILES_ROOT/fonts/MapleMono" "$HOME/.local/share/fonts/MapleMono"
run fc-cache -f "$HOME/.local/share/fonts/ComicShanns" "$HOME/.local/share/fonts/MapleMono"
link_file "$DOTFILES_ROOT/config/git/gitignore" "${XDG_CONFIG_HOME:-$HOME/.config}/git/ignore"
link_file "$DOTFILES_ROOT/profiles/omarchy/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link_file "$DOTFILES_ROOT/config/tmux/scripts" "$HOME/.tmux/scripts"
link_file "$DOTFILES_ROOT/profiles/omarchy/kitty/local.conf" "$HOME/.config/kitty/local.conf"
install_cursor_settings "$DOTFILES_ROOT/profiles/omarchy/cursor/settings.json" "$HOME/.config/Cursor/User/settings.json"
link_file "$DOTFILES_ROOT/profiles/omarchy/cursor/keybindings.json" "$HOME/.config/Cursor/User/keybindings.json"
link_file "$DOTFILES_ROOT/profiles/omarchy/nvim/init.lua" "$HOME/.config/nvim/init.lua"
link_file "$DOTFILES_ROOT/config/nvim/lua/user" "$HOME/.config/nvim/lua/dotfiles_legacy"
link_file "$DOTFILES_ROOT/profiles/omarchy/nvim" "$HOME/.config/nvim/lua/omarchy_profile"
link_file "$DOTFILES_ROOT/config/nvim/snippets" "$HOME/.config/nvim/snippets/dotfiles"
link_children "$DOTFILES_ROOT/config/nvim/lsp" "$HOME/.config/nvim/lsp"
link_file "$DOTFILES_ROOT/quotes/quotes.txt" "$HOME/.quotes.txt"
link_file "$DOTFILES_ROOT/bin/project-switcher" "$HOME/.local/bin/p"
link_file "$DOTFILES_ROOT/profiles/omarchy/shell/aliases.sh" "$HOME/.config/bash/dotfiles.sh"
ensure_source_line "$HOME/.bashrc" '[[ -r "$HOME/.config/bash/dotfiles.sh" ]] && source "$HOME/.config/bash/dotfiles.sh"'

log "Preserved: Omarchy terminal theme and settings outside kitty/local.conf, shell, Hyprland, bar, Cursor and Neovim theme files"
