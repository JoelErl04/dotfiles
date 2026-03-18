#!/usr/bin/env bash
INI="$HOME/dotfiles/themes/active/colors.ini"
OUT="$HOME/dotfiles/themes/active/kitty-colors.conf"

get() { grep "^$1" "$INI" | sed 's/.*= *//' | tr -d '[:space:]'; }

background=$(get background)
foreground=$(get foreground)
subtle=$(get subtle)
surface=$(get surface)
accent_primary=$(get accent_primary)
accent_secondary=$(get accent_secondary)
accent_urgent=$(get accent_urgent)
border_inactive=$(get border_inactive)

cat > "$OUT" <<EOF
foreground              #${foreground}
background              #${background}

selection_foreground    #${background}
selection_background    #${accent_secondary}

cursor                  #${accent_secondary}
cursor_text_color       #${background}

url_color               #${accent_primary}

color0   #${background}
color8   #${border_inactive}
color1   #${accent_urgent}
color9   #d4784e
color2   #${accent_primary}
color10  #96aa72
color3   #${accent_secondary}
color11  #dfc26a
color4   #5e7a8c
color12  #7496aa
color5   #8c6670
color13  #aa7e8a
color6   #5c8c7e
color14  #72aa9c
color7   #${subtle}
color15  #${foreground}

active_tab_foreground   #${background}
active_tab_background   #${accent_secondary}
inactive_tab_foreground #${subtle}
inactive_tab_background #${surface}
EOF

echo "Generated $OUT"
