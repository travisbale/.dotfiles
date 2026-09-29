# Include ~/.local/bin in PATH (idempotent — .zshenv is sourced for every shell)
if [ -d "$HOME/.local/bin" ]; then
    case ":$PATH:" in
        *":$HOME/.local/bin:"*) ;;
        *) PATH="$HOME/.local/bin:$PATH" ;;
    esac
fi

# Include Go binaries in PATH (idempotent)
if [ -d "$HOME/go/bin" ]; then
    case ":$PATH:" in
        *":$HOME/go/bin:"*) ;;
        *) PATH="$HOME/go/bin:$PATH" ;;
    esac
fi

# Include Google Cloud SDK in PATH (idempotent — its own path.zsh.inc prepends
# unconditionally, so nested shells accumulated duplicate entries)
if [ -d "$HOME/.local/share/google-cloud-sdk/bin" ]; then
    case ":$PATH:" in
        *":$HOME/.local/share/google-cloud-sdk/bin:"*) ;;
        *) PATH="$HOME/.local/share/google-cloud-sdk/bin:$PATH" ;;
    esac
fi

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
