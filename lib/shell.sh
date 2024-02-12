function isZsh() {
    case $SHELL in
        */zsh)
            return true
            ;;
        *)
            return false
    esac
}
