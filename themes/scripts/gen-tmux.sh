#!/usr/bin/env bash
INI="$HOME/dotfiles/themes/active/colors.ini"
TEMPLATE="$HOME/dotfiles/tmux/tmux.conf.template"
OUT="$HOME/dotfiles/tmux/tmux.conf"

get() { grep "^$1" "$INI" | sed 's/.*= *//' | tr -d '[:space:]'; }

sed \
    -e "s/{{background}}/$(get background)/g" \
    -e "s/{{foreground}}/$(get foreground)/g" \
    -e "s/{{accent_secondary}}/$(get accent_secondary)/g" \
    -e "s/{{muted}}/$(get muted)/g" \
    -e "s/{{border_inactive}}/$(get border_inactive)/g" \
    -e "s/{{border_active}}/$(get border_active)/g" \
    "$TEMPLATE" > "$OUT"

echo "Generated $OUT"
