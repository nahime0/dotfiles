# Portable personal aliases loaded after Omarchy's Bash defaults.

# Use 1Password for SSH clients and Git commit signing in interactive shells.
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# Media
alias get-music="yt-dlp -o '%(playlist_index)02d - %(title)s.%(ext)s' -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata --parse-metadata ':%(meta_comment)s' --parse-metadata ':%(meta_synopsis)s' --parse-metadata ':%(meta_description)s' --parse-metadata 'playlist_index:%(track_number)s'"
alias get-video='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
alias get-video-and-subs='yt-dlp --write-subs --write-auto-subs --sub-langs "en,it" --convert-subs srt -o "%(title)s.%(ext)s"'

# Development
alias t='tmux new -As0'
alias td='toodoo'
alias co='composer'
alias a='php artisan'
alias which-php="jq -r '.require.php // .config.platform.php // empty' composer.json | grep -oE '[0-9]+\.[0-9]+'"

# Git
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gd='git diff'
alias gp='git push'
alias gpu='git pull --rebase'
alias gis='git status -sb'
alias gsta='git stash'
alias gstap='git stash pop'
alias gsps='git stash && git pull --rebase && git stash pop'
alias gitbackup='git add -A && git commit -m "backup: $(date +"%Y-%m-%d %H:%M:%S")"'

# AI agents
alias yolo.claude='claude --dangerously-skip-permissions'
alias yolo.codex='codex --dangerously-bypass-approvals-and-sandbox'
alias yolo.kimi='kimi --yolo'
alias yolo.grok='grok --permission-mode bypassPermissions'

# Shell
alias ll='eza -la --icons'
alias lt='eza --tree --icons'
alias ssh='TERM=xterm-256color ssh'

# Personal Git tools (shell navigation and Bash completion)
if command -v ggg >/dev/null 2>&1; then
  eval "$(command ggg shell-init bash)"
fi

if command -v ggw >/dev/null 2>&1; then
  eval "$(command ggw shell-init bash)"
fi

# tmux drops DISPLAY and WAYLAND_DISPLAY when a client without them attaches.
# xdg-open then runs $BROWSER, so `open .` opens the browser instead of
# Nautilus. Fill only the names this shell is missing, and only when the local
# sockets exist. A stale SSH_CONNECTION left in the tmux session is not a
# reason to skip: these panes are still on this machine.
__restore_graphical_session() {
  local runtime="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
  local sock
  [[ -d $runtime ]] || return 0
  if [[ -z ${WAYLAND_DISPLAY:-} ]]; then
    for sock in "$runtime"/wayland-*; do
      [[ -S $sock ]] || continue
      export WAYLAND_DISPLAY="${sock##*/}"
      break
    done
  fi
  if [[ -z ${DISPLAY:-} && -S /tmp/.X11-unix/X0 ]]; then
    export DISPLAY=:0
  fi
  if [[ -n ${WAYLAND_DISPLAY:-} ]]; then
    if [[ -z ${XDG_SESSION_TYPE:-} || ${XDG_SESSION_TYPE} == tty ]]; then
      export XDG_SESSION_TYPE=wayland
    fi
    if [[ -z ${XDG_CURRENT_DESKTOP:-} && -d $runtime/hypr ]]; then
      export XDG_CURRENT_DESKTOP=Hyprland
    fi
    if [[ -z ${XDG_SESSION_DESKTOP:-} && -d $runtime/hypr ]]; then
      export XDG_SESSION_DESKTOP=Hyprland
    fi
  fi
}
__restore_graphical_session
unset -f __restore_graphical_session
