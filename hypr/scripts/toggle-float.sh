#!/usr/bin/env bash
floating=$(hyprctl -j activewindow | jq -r '.floating')
hyprctl dispatch togglefloating
if [[ "$floating" == "false" ]]; then
    hyprctl dispatch resizeactive exact 1280 720
    hyprctl dispatch centerwindow
fi
