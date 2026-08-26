# Portable personal aliases loaded after Omarchy's Bash defaults.

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
