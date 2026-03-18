#!/usr/bin/env bash
INI="$HOME/dotfiles/themes/active/colors.ini"
OUT="$HOME/dotfiles/themes/active/hyprland-colors.conf"

get() { grep "^$1" "$INI" | sed 's/.*= *//' | tr -d '[:space:]'; }

background=$(get background)
surface=$(get surface)
overlay=$(get overlay)
foreground=$(get foreground)
subtle=$(get subtle)
muted=$(get muted)
accent_primary=$(get accent_primary)
accent_secondary=$(get accent_secondary)
accent_urgent=$(get accent_urgent)
border_active=$(get border_active)
border_inactive=$(get border_inactive)

cat > "$OUT" <<EOF
\$col_background       = rgba(${background}ff)
\$col_surface          = rgba(${surface}ff)
\$col_overlay          = rgba(${overlay}ff)
\$col_foreground       = rgba(${foreground}ff)
\$col_subtle           = rgba(${subtle}ff)
\$col_muted            = rgba(${muted}ff)
\$col_accent_primary   = rgba(${accent_primary}ff)
\$col_accent_secondary = rgba(${accent_secondary}ff)
\$col_accent_urgent    = rgba(${accent_urgent}ff)
\$col_border_active    = rgba(${border_active}ee)
\$col_border_inactive  = rgba(${border_inactive}aa)
\$col_shadow           = rgba(${background}ee)
EOF

echo "Generated $OUT"
