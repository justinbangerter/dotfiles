#~/.xinitrc - executed by X on startup
command -v xmodmap >/dev/null 2>&1 && {
    [ -f $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap
}