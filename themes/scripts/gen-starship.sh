#!/usr/bin/env bash
INI="$HOME/dotfiles/themes/active/colors.ini"
TEMPLATE="$HOME/dotfiles/starship.toml.template"
OUT="$HOME/dotfiles/starship.toml"

get() { grep "^$1" "$INI" | sed 's/.*= *//' | tr -d '[:space:]'; }

sed \
    -e "s/{{accent_primary}}/$(get accent_primary)/g" \
    -e "s/{{accent_secondary}}/$(get accent_secondary)/g" \
    -e "s/{{accent_urgent}}/$(get accent_urgent)/g" \
    -e "s/{{muted}}/$(get muted)/g" \
    "$TEMPLATE" > "$OUT"

echo "Generated $OUT"
