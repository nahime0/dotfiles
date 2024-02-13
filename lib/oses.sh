# Detect the operating system

case "$(uname -sr)" in
    Darwin*)
        export OS='macos'
        ;;
    Linux*Microsoft*)
        export OS='wsl'
        ;;
    Linux*)
        export OS='linux'
        ;;
    # CYGWIN*|MINGW*|MINGW32*|MSYS*)
    #     OS='Windows'
    #     ;;
    *)
        export OS='other'
        ;;
esac
