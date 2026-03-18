#!/usr/bin/env bash
THEMES_DIR="$HOME/dotfiles/themes"
ACTIVE="$THEMES_DIR/active"

if [[ -z "$1" ]]; then
    echo "Usage: switch-theme.sh <theme-name>"
    echo "Available themes:"
    ls "$THEMES_DIR" | grep -v -E '^(active|scripts)$'
    exit 1
fi

TARGET="$THEMES_DIR/$1"

if [[ ! -d "$TARGET" ]]; then
    echo "Error: theme '$1' not found in $THEMES_DIR"
    exit 1
fi

ln -sfn "$TARGET" "$ACTIVE"
echo "Switched active theme to: $1"

for script in "$THEMES_DIR/scripts"/gen-*.sh; do
    bash "$script"
done

hyprctl reload
echo "Hyprland reloaded."
