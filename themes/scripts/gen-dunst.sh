#!/usr/bin/env bash
INI="$HOME/dotfiles/themes/active/colors.ini"
TEMPLATE="$HOME/dotfiles/dunst/dunstrc.template"
OUT="$HOME/dotfiles/dunst/dunstrc"

get() { grep "^$1" "$INI" | sed 's/.*= *//' | tr -d '[:space:]'; }

sed \
    -e "s/{{surface}}/#$(get surface)/g" \
    -e "s/{{foreground}}/#$(get foreground)/g" \
    -e "s/{{border_inactive}}/#$(get border_inactive)/g" \
    -e "s/{{border_active}}/#$(get border_active)/g" \
    -e "s/{{accent_urgent}}/#$(get accent_urgent)/g" \
    "$TEMPLATE" > "$OUT"

echo "Generated $OUT"
