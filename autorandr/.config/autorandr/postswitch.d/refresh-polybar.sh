#!/bin/bash
notify-send -i display "Display profile" "$AUTORANDR_CURRENT_PROFILE"
#~/.config/polybar/launch.sh --material
i3-msg restart
