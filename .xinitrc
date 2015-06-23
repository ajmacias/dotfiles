#!/bin/bash

# here we go!
xrdb -load ~/.Xresources &                      # some colors
xset -b &                                       # no beep!
volwheel &                                      # volume tray icon
dropbox &                                       # dropbox

xscreensaver -no-splash &                       # screensaver

# wallpaper - random
#feh --bg-fill "$(find ~/wallpapers/ -type f | sort -R | tail -1)"

# wallpaper - random & !repeat
OLDWALLPAPER=$(cat ~/.fehbg | cut -d \' -f 2)
feh --bg-fill "$(find ~/wallpapers/ -type f | grep -v $OLDWALLPAPER | sort -R | tail -1)"

autocutsel -fork &                              # unify cut&paste
autocutsel -selection PRIMARY -fork &

thunar --daemon &

xrandr --dpi 96                                 # Set 96 DPI res

#exec i3
