#!/usr/bin/env bash

# Terminate already running bar instances
killall -q plank

# Wait until the processes have been shut down
# while pgrep -u $UID -x plank >/dev/null; do sleep 1; done

# Launch dock1 and dock2
plank -n dock1 &
plank -n dock2 &
