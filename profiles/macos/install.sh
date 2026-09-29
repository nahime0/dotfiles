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
clone_git_repo "https://github.com/sandudorogan/tmux-pane-tree.git" "$HOME/.config/tmux/plugins/tmux-pane-tree" "d1053873c236e11168c5b7b3a296233fc80224ef"
apply_git_patch "$DOTFILES_ROOT/config/tmux/patches/tmux-pane-tree-local-fixes.patch" "$HOME/.config/tmux/plugins/tmux-pane-tree"
clone_git_repo "https://github.com/omerxx/tmux-sessionx.git" "$HOME/.config/tmux/plugins/tmux-sessionx"
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

# GUI applications build their PATH from path_helper, which reads /etc/paths and
# /etc/paths.d and never a shell profile. Without this, mise's tools are
# invisible to any process an application spawns: git-lfs and difftastic would
# silently stop working whenever git runs from an IDE rather than the terminal.
# Homebrew registers itself the same way, through /etc/paths.d/homebrew.
#
# This is the one step of the profile that needs root, and it asks only when the
# file is missing or stale.
register_mise_shims() {
  local shims="$HOME/.local/share/mise/shims" target=/etc/paths.d/mise

  if [[ -f "$target" ]] && grep -Fxq "$shims" "$target"; then
    log "unchanged: $target"
    return
  fi

  if [[ "$DOTFILES_APPLY" != true ]]; then
    printf '+ write %q to %q (needs sudo)\n' "$shims" "$target"
    return
  fi

  log "Registering mise's shims for GUI applications; sudo will ask for your password"
  if ! printf '%s\n' "$shims" | sudo tee "$target" >/dev/null; then
    log "warning: could not write $target, so GUI applications will not see mise's"
    log "         tools. Everything else was installed; re-run to try again."
  fi
}

# The same blind spot, for the SSH agent: launchd hands GUI applications the
# system agent's socket, while the commit signing key lives in Bitwarden's. Git
# then fails with "Couldn't find key in agent?" whenever it runs from Obsidian
# or an IDE rather than from a terminal. config/zsh/zshrc covers the shell side.
#
# The socket path is fixed, so the agent only has to publish it once per login.
register_gui_ssh_agent() {
  local label=me.nahi.ssh-auth-sock
  local socket="$HOME/.bitwarden-ssh-agent.sock"
  local target="$HOME/Library/LaunchAgents/$label.plist"
  local plist

  plist=$(cat <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>$label</string>
	<key>ProgramArguments</key>
	<array>
		<string>/bin/launchctl</string>
		<string>setenv</string>
		<string>SSH_AUTH_SOCK</string>
		<string>$socket</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>
PLIST
)

  if [[ -f "$target" && "$(cat "$target")" == "$plist" ]]; then
    log "unchanged: $target"
    return
  fi

  if [[ "$DOTFILES_APPLY" != true ]]; then
    printf '+ write %q and load it with launchctl\n' "$target"
    return
  fi

  backup_path "$target"
  ensure_dir "$(dirname -- "$target")"
  printf '%s\n' "$plist" >"$target"

  # Only applications started from here on inherit it: a running one keeps the
  # environment it was launched with.
  launchctl bootout "gui/$UID/$label" 2>/dev/null || true
  if launchctl bootstrap "gui/$UID" "$target" 2>/dev/null; then
    launchctl setenv SSH_AUTH_SOCK "$socket"
  else
    log "warning: could not load $label, so GUI applications will only pick the"
    log "         agent up after the next login."
  fi
}

link_file "$DOTFILES_ROOT/quotes/quotes.txt" "$HOME/.quotes.txt"
link_file "$DOTFILES_ROOT/bin/project-switcher" "$HOME/bin/p"
link_file "$DOTFILES_ROOT/bin/ray" "$HOME/bin/ray"
link_file "$DOTFILES_ROOT/bin/tailscale-config" "$HOME/bin/tailscale-config"

register_gui_ssh_agent

# Last: it is the only step that can prompt, and a declined password must not
# stop the file links above or the private repository's setup that follows.
register_mise_shims
