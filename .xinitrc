#~/.xinitrc - executed by X on startup
command -v xmodmap >/dev/null 2>&1 && {
    [ -f $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap
}

session=${1:-i3}

case $session in
  dwm ) exec dwm;;
  i3|i3wm ) exec i3;;
  xmonad ) exec xmonad;;
  *) exec $1;;
esac
