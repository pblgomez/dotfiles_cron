#!/usr/bin/env bash
app="rofi -show run -dmenu"
poweroff=$(echo -e "suspend\npoweroff\nlogout\nreboot" | $app -p "Shutdown menu")
case $poweroff in
  suspend) systemctl suspend & ;;
  poweroff) systemctl poweroff & ;;
  logout) killall xinit || bspc quit || swaymsg exit & ;;
  reboot) systemctl reboot & ;;
esac
