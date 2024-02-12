# Detect the operating system

case "$(uname -sr)" in
    Darwin*)
        OS='macOS'
        ;;
    Linux*Microsoft*)
        OS='WSL'
        ;;
    Linux*)
        OS='Linux'
        ;;
    # CYGWIN*|MINGW*|MINGW32*|MSYS*)
    #     OS='Windows'
    #     ;;
    *)
        OS='Other'
        ;;
esac

function isMacOS() {
    [ "$OS" = "macOS" ]
}

function isWSL() {
    [ "$OS" = "WSL" ]
}

function isLinux() {
    [ "$OS" = "Linux" ]
}

function isWindows() {
    [ "$OS" = "Windows" ]
}

function isOther() {
    [ "$OS" = "Other" ]
}
