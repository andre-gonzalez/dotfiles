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

# Compositor
xcompmgr -c &

# set keyboard layout to dvorak, change esc with caps lock and change numpad , to . (dot)
setxkbmap -layout us -variant dvorak-intl && setxkbmap -option caps:swapescape &

#Keybinds for audio and backlight
xbindkeys &

# DWM Status
dwmblocks &

# unclutter to make the mouse dissapear when not using it
unclutter &

# insync start
insync start &

#start clipmenud
clipmenud &

#fast scroll with j and k in vim
xset r rate 400 50 &

# Xautolock to lock screen after some time of inactivity
xautolock -time 10 -locker slock -notify 2 -corners ---- &

# Fix a bug in the bluetooth
rfkill unblock all &

#Activate numlock on boot
numlockx &

# Polkit agent
lxsession &

# Multiple Monitor configuration
# if [ $(xrandr --query | grep -c HDMI) = 1 ]; then
# 		if [ $(xrandr --query | grep  HDMI | grep -c 2560x1080) = 1 ]; then
# 			# Only use ultra-wide monitor
# 			xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 2560x1080 --pos 1920x0 --rotate normal
# 			# Use ultra-wide monitor and laptop screen
# 			# xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --primary --mode 2560x1080 --pos 1920x0 --rotate normal --rate 75
# 		fi
# 	elif [ $(xrandr --query | grep -c eDP-1) = 1]; then
# 		xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off
# fi

# Load Xresources (font rendering, DPI, etc.)
xrdb -merge ~/.Xresources &

# Set correct DPI for your ultrawide
xrandr --dpi 109 &

# Restore display layout via autorandr
autorandr --change &

# Wallpaper
/bin/dash "$HOME"/.scripts/random-wallpaper.sh

# Loop
while true; do
	dwm > /dev/null 2>&1
done

# Shell definition
SHELL=/bin/fish

#Execute DWM
exec dwm
