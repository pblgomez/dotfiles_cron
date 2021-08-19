#!/usr/bin/env dash

pbl_pulse () {
  CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -f3 -d" ")
  STATUS=$(pactl list sources | grep -A 10 $CURRENT_SOURCE | grep "Mute" | awk '{print $2}')
  printf "%s" "$SEP1"
  if [ "$STATUS" = "yes" ]; then
    printf ""
  else
    printf ""
  fi
  printf "%s\n" "$SEP2"
}

pbl_pulse
