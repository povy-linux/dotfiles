#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# xsetroot -name " povy-0.1 " &
while xsetroot -name " Vol: $(pactl list sinks | grep '^[[:space:]]Volume:' |     head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')% `date +'%b %d %H:%M:%S'` `uptime | sed 's/.*,//'` povy-0.1 "
do
  sleep 1
done &
# xrandr --output eDP1 -s 1920x1080 &
# xrandr --output HDMI1 --auto --right-of eDP1 &
xrandr -s 1920x1080 &
picom &
nitrogen --restore &
lxsession &
# exec dwm
exec dbus-run-session dwm
