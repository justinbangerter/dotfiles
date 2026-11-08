#~/.xinitrc - executed by X on startup

xrandr --setprovideroutputsource modestting NVIDIA-0
xrandr --auto
xrandr --dpi 96

xrandr --output DP-2 --left-of eDP-1
xrandr --output DP-2 --primary

command -v xmodmap >/dev/null 2>&1 && {
    [ -f $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap
}
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

sxhkd &     # key binding daemon
dunst &     # screen notification daemon

session=${1:-i3}

case $session in
  i3|i3wm ) exec dbus-run-session i3 --shmlog-size=26214400;;
  xmonad ) exec xmonad;;
  dwm ) exec dwm;;
  *) exec $1;;
esac
