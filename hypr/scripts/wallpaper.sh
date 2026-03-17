#!/bin/bash

WALLPAPER_DIR="$HOME/media/pictures/wallpapers"
LAST=""

while true; do
    NEXT=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | \
    shuf -n 1)

    [ -z "$NEXT" ] && { sleep 10; continue; }

    if [ "$NEXT" = "$LAST" ]; then
        continue
    fi

    swww img "$NEXT" \
        --transition-type fade \
        --transition-duration 2 \
        --transition-fps 60

    LAST="$NEXT"
    sleep 120
done
