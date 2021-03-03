#!/usr/bin/bash

# ADD TO SUDOERS
# %wheel ALL=(ALL) NOPASSWD: /usr/bin/cpupower

# TEST
# kill -USR1 $(pgrep -l 'cpu-governor')

# POLYBAR CONFIG (icon: waffle (siji))
# [module/cpu-governor]
# type = custom/script
# exec = $HOME/.config/polybar/material/scripts/cpu-governor.sh
# tail = true
# click-left = kill -USR1 %pid%
# format-prefix = " "

available_governors=($(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors))

for g in "${available_governors[@]}"; do 
  echo "found available governor: $g"
done

function get_current_governor() {
  cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

function toggle_current_governor() {
  current_governor=$(get_current_governor)
  first_governor=""
  next_governor=""
  prev_g=""

  for g in "${available_governors[@]}"; do 
    if [[ "$first_governor" == "" ]]; then
      first_governor=$g
    fi

    if [[ "$prev_g" == "$current_governor" ]]; then
      next_governor=$g
    fi

    prev_g=$g
  done

  if [[ "$next_governor" == "" ]]; then
    next_governor=$first_governor
  fi

  sudo cpupower frequency-set -g $next_governor \
    && get_current_governor
}

trap toggle_current_governor SIGUSR1

while :
do
  get_current_governor
  sleep 1
done

# vim:set ts=2 sw=2 ft=sh et:
