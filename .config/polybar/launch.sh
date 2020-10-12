#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bar1 and bar2
polybar bar1 &
polybar bar2 &

echo "Polybars launched..."
