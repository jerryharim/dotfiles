#!/bin/sh

exec feh --bg-fill ~/.config/wallpaper &
exec polybar &
exec pulseaudio -D &
exec picom &
exec exhkd &

# Launch with a dbus session (recommended)
exec dbus-launch --exit-with-session i3 
