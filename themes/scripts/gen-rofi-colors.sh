#!/usr/bin/env bash
INI="$HOME/dotfiles/themes/active/colors.ini"
OUT="$HOME/dotfiles/themes/active/rofi-colors.rasi"

get() { grep "^$1" "$INI" | sed 's/.*= *//' | tr -d '[:space:]'; }

background=$(get background)
surface=$(get surface)
overlay=$(get overlay)
foreground=$(get foreground)
subtle=$(get subtle)
accent_primary=$(get accent_primary)
accent_secondary=$(get accent_secondary)
border_active=$(get border_active)
border_inactive=$(get border_inactive)

cat > "$OUT" <<EOF
* {
    bg:         #${background};
    surface:    #${surface};
    overlay:    #${overlay};
    fg:         #${foreground};
    subtle:     #${subtle};
    accent:     #${accent_secondary};
    accent-alt: #${accent_primary};
    border-col: #${border_active};
    border-off: #${border_inactive};
}
EOF

echo "Generated $OUT"
