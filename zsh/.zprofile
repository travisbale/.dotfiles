# Re-source .zshenv to restore PATH additions clobbered by /etc/profile
. "$HOME/.zshenv"

# Allow local X11 connections for LXD containers
if [ -n "$DISPLAY" ]; then
    xhost +local: >/dev/null 2>&1
fi
