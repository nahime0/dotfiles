#!/usr/bin/env bash
[[ "$DOTFILES_APPLY" != true || $(uname -s) == Linux ]] || die "The omarchy profile requires Linux"
[[ "$DOTFILES_APPLY" != true ]] || command -v omarchy >/dev/null 2>&1 || die "The omarchy command was not found"
[[ "$DOTFILES_APPLY" != true ]] || command -v fc-cache >/dev/null 2>&1 || die "fc-cache is required to install fonts"

link_children "$DOTFILES_ROOT/fonts/ComicShanns" "$HOME/.local/share/fonts/ComicShanns"
run fc-cache -f "$HOME/.local/share/fonts/ComicShanns"
link_file "$DOTFILES_ROOT/profiles/omarchy/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link_file "$DOTFILES_ROOT/config/tmux/scripts" "$HOME/.tmux/scripts"
link_file "$DOTFILES_ROOT/profiles/omarchy/kitty/local.conf" "$HOME/.config/kitty/local.conf"
link_file "$DOTFILES_ROOT/profiles/omarchy/nvim/init.lua" "$HOME/.config/nvim/init.lua"
link_file "$DOTFILES_ROOT/config/nvim/lua/user" "$HOME/.config/nvim/lua/dotfiles_legacy"
link_file "$DOTFILES_ROOT/profiles/omarchy/nvim" "$HOME/.config/nvim/lua/omarchy_profile"
link_file "$DOTFILES_ROOT/config/nvim/snippets" "$HOME/.config/nvim/snippets/dotfiles"
link_file "$DOTFILES_ROOT/quotes/quotes.txt" "$HOME/.quotes.txt"
link_file "$DOTFILES_ROOT/bin/project-switcher" "$HOME/.local/bin/p"
link_file "$DOTFILES_ROOT/profiles/omarchy/shell/aliases.sh" "$HOME/.config/bash/dotfiles.sh"
ensure_source_line "$HOME/.bashrc" '[[ -r "$HOME/.config/bash/dotfiles.sh" ]] && source "$HOME/.config/bash/dotfiles.sh"'

log "Preserved: Omarchy terminal theme and settings outside kitty/local.conf, shell, Hyprland, bar and Neovim theme files"
