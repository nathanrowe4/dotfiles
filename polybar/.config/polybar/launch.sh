#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bar on each monitor
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload laptop &
  done
else
  polybar --reload laptop &
fi
