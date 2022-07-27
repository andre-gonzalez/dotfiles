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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# set keyboard layout to dvorak, change esc with caps lock and change numpad , to . (dot)
setxkbmap -layout us -variant dvorak-intl && setxkbmap -option caps:escape

#Keybinds for audio and backlight
xbindkeys &

# DWM Status
dwmblocks &

# unclutter to make the mouse dissapear when not using it
unclutter &

# insync start
insync start &

# start xflux so the screen get orange in the night
xflux -l -23 -g -43.4 -k 2700 &

#start clipmenud
clipmenud &

#fast scroll with j and k in vim
xset r rate 400 50

# Xautolock to lock screen after some time of inactivity
xautolock -time 10 -locker slock -notify 2 &

# Fix a bug in the bluetooth
rfkill unblock all &

#Activate numlock on boot
numlockx &

# Multiple Monitor configuration
xrandr --output eDP-1 --mode 1920x1080 --pos 1360x434 --rotate normal --output HDMI-1 --primary --mode 1360x768 --pos 0x0 --rotate normal

#Wallpaper
feh --bg-fill "$HOME"/.config/.wallpaper/montanhas-e-nuvens.jpg

# Turn off bluetooth
bluetoothctl power off

# Loop
while true; do
	dwm > /dev/null 2>&1
done

#Execute DWM
exec dwm
