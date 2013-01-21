#!/bin/bash

# system defaults
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# here we go!
xrdb -merge ~/.Xresources &                     # some colors
xset -b &                                       # no beep!
xcompmgr &                                      # 
autocutsel -fork &                              # unify cut&paste
autocutsel -selection PRIMARY -fork &
xscreensaver -no-splash &                       # screensaver & screenlocker
thunar --daemon &                               # filemanager
(sleep 5 && dropboxd) &                         # dropbox

xrandr --dpi 96                                 # Set 96 DPI res

exec awesome                                    # awesome wm ;)

