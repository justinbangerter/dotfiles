#~/.xinitrc - executed by X on startup

xrandr --setprovideroutputsource modestting NVIDIA-0
xrandr --auto
xrandr --dpi 96

command -v xmodmap >/dev/null 2>&1 && {
    [ -f $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap
}
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

sxhkd &     # key binding daemon
dunst &     # screen notification daemon

session=${1:-i3}

case $session in
  dwm ) exec dwm;;
  i3|i3wm ) exec i3;;
  xmonad ) exec xmonad;;
  *) exec $1;;
esac
