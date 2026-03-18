#!/usr/bin/env bash
SCREENSHOTS_DIR="${XDG_SCREENSHOTS_DIR:-$HOME/media/pictures/screenshots}"
FILE="$SCREENSHOTS_DIR/$(date +%Y%m%d-%H%M%S).png"

geometry=$(slurp -b '#1e1c1acc' -c '#c9a84cff' -s '#00000000' -B 2) || exit 1

grim -g "$geometry" "$FILE"
wl-copy < "$FILE"
notify-send "Screenshot saved" "$FILE"
