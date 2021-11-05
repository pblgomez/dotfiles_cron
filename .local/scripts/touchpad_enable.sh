#!/usr/bin/env bash

mapfile -t < <(xinput --list --name-only | grep Touchpad)
mapfile -t DEVICES < <(xinput --list --name-only | grep Touchpad)
for i in "${DEVICES[@]}"; do
  printf "device: %s\n" "$i"
  mapfile -t DEVICEPROPS < <(xinput --list-props "$i" | awk -F'[()]' '/Tapping Enabled \(/ {print $2}')
  printf "device property: %s\n" "${DEVICEPROPS[@]}"
  xinput set-prop "$i" "${DEVICEPROPS[0]}" 1 && printf "Enabled touchpad in device: %s\n\n" "$i"
done
