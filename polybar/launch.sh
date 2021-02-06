#!/usr/bin/env bash

dir="$HOME/.config/polybar"

launch_bar() {
    echo "Launching $2 bar(s) on $1"
    MONITOR=$1 IFACE_ETH=${eth} IFACE_WLAN=${wlan} polybar -q $2 -c "$dir/material/config.ini" &	
}

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

eth=$(ip link | grep -m 1 -E '\b(en)' | awk '{print substr($2, 1, length($2)-1)}')
wlan=$(ip link | grep -m 1 -E '\b(wl)' | awk '{print substr($2, 1, length($2)-1)}')
echo "Found network interfaces: $eth (eth), $wlan (wlan)"

# Use newline as field separator for looping over lines
IFS=$'\n'

for screen in $(xrandr --query | grep -w connected); do
    # Substring removal, delete everything after first space
    output=${screen%% *}
    printf "Found output: %s\\n" "${output}"

    case ${screen} in
        *primary*)
          launch_bar "${output}" main
          ;;
        *)
        launch_bar "${output}" secondary
        ;;
    esac
done

