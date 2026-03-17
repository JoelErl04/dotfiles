#!/bin/bash

CHOICES="󰐥  Power Off\n󰜉  Restart\n󰒲  Suspend\n󰍃  Log Out\n󰌾  Lock"

CHOSEN=$(echo -e "$CHOICES" | rofi -dmenu \
    -i \
    -p "  Power" \
    -theme-str 'window {width: 300px;}' \
    -theme-str 'listview {lines: 5;}')

case "$CHOSEN" in
    *"Power Off") systemctl poweroff ;;
    *"Restart")   systemctl reboot ;;
    *"Suspend")   systemctl suspend ;;
    *"Log Out")   hyprctl dispatch exit ;;
    *"Lock")      hyprlock ;;
esac
