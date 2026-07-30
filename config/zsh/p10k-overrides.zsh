# Persistent Powerlevel10k customizations.
# Keep this file outside p10k.zsh because `p10k configure` rewrites that file.

typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER='…'
typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# In SSH sessions, show only the host instead of user@host.
typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%m'

# Use Kitty's ANSI palette for semantic foregrounds. Select the raised prompt
# background from the macOS appearance on startup and before each prompt.
_dotfiles_p10k_theme_background() {
  if [[ $OSTYPE == darwin* ]] &&
      [[ $(defaults read -g AppleInterfaceStyle 2>/dev/null) == 'Dark' ]]; then
    print -r -- '#3B4252'
  else
    print -r -- '#D8DEE9'
  fi
}

typeset -g POWERLEVEL9K_BACKGROUND=$(_dotfiles_p10k_theme_background)
typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%F{7}\u2571'
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%F{7}\u2571'
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0BC'
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0BA'
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0BC'
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0BA'

# Keep the multiline ornaments legible through the theme-aware ANSI palette.
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%F{7}╭─'
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%F{7}├─'
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{7}╰─'
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX='%F{7}─╮'
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX='%F{7}─┤'
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX='%F{7}─╯'

for color_parameter in ${(k)parameters[(I)POWERLEVEL9K_*_FOREGROUND]}; do
  color_value=${(P)color_parameter}

  case ${color_value:l} in
    '#ae4750') typeset -g "$color_parameter=1" ;;
    '#577140') typeset -g "$color_parameter=2" ;;
    '#7f6614') typeset -g "$color_parameter=3" ;;
    '#3b5e85') typeset -g "$color_parameter=4" ;;
    '#865b7f') typeset -g "$color_parameter=5" ;;
    '#0c7482') typeset -g "$color_parameter=6" ;;
    '#2e3440'|'#5f6a7e') typeset -g "$color_parameter=7" ;;
    '#4b6c8c') typeset -g "$color_parameter=12" ;;
    '#975943') typeset -g "$color_parameter=11" ;;
    '#1c7473') typeset -g "$color_parameter=14" ;;
  esac
done

unset color_parameter color_value

_dotfiles_p10k_refresh_appearance() {
  emulate -L zsh

  local theme_background=$(_dotfiles_p10k_theme_background)
  [[ $POWERLEVEL9K_BACKGROUND == $theme_background ]] && return

  typeset -g POWERLEVEL9K_BACKGROUND=$theme_background
  (( ! $+functions[p10k] )) || p10k reload
}

autoload -Uz add-zsh-hook
add-zsh-hook -d precmd _dotfiles_p10k_refresh_appearance 2>/dev/null
add-zsh-hook precmd _dotfiles_p10k_refresh_appearance

(( ! $+functions[p10k] )) || p10k reload
