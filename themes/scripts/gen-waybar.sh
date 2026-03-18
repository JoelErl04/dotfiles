#!/usr/bin/env bash
INI="$HOME/dotfiles/themes/active/colors.ini"
CSS_OUT="$HOME/dotfiles/themes/active/waybar-colors.css"
CFG_TEMPLATE="$HOME/dotfiles/waybar/config.jsonc.template"
CFG_OUT="$HOME/dotfiles/waybar/config.jsonc"

get() { grep "^$1" "$INI" | sed 's/.*= *//' | tr -d '[:space:]'; }

hex_to_rgb() {
    local h=$1
    printf "%d, %d, %d" "0x${h:0:2}" "0x${h:2:2}" "0x${h:4:2}"
}

background=$(get background)
surface=$(get surface)
overlay=$(get overlay)
foreground=$(get foreground)
subtle=$(get subtle)
muted=$(get muted)
accent_primary=$(get accent_primary)
accent_secondary=$(get accent_secondary)
accent_urgent=$(get accent_urgent)

pill_rgb=$(hex_to_rgb "$surface")
bg_rgb=$(hex_to_rgb "$background")

cat > "$CSS_OUT" <<EOF
@define-color text        #${foreground};
@define-color subtext     #${subtle};
@define-color overlay     #${muted};
@define-color surface     #${overlay};
@define-color pill        rgba(${pill_rgb}, 0.90);

@define-color accent-ws       #${accent_secondary};
@define-color accent-clock    #${accent_secondary};
@define-color accent-volume   #${foreground};
@define-color accent-bright   #${accent_secondary};
@define-color accent-bt       #${subtle};
@define-color accent-wifi     #${accent_primary};
@define-color accent-battery  #${accent_primary};

@define-color state-warn      #${accent_secondary};
@define-color state-crit      #${accent_urgent};
@define-color state-charge    #${accent_primary};

@define-color tooltip-bg      rgba(${bg_rgb}, 0.95);
@define-color blink-text      rgba(${bg_rgb}, 1);
EOF

echo "Generated $CSS_OUT"

sed \
    -e "s/{{foreground}}/${foreground}/g" \
    -e "s/{{muted}}/${muted}/g" \
    -e "s/{{accent_primary}}/${accent_primary}/g" \
    -e "s/{{accent_urgent}}/${accent_urgent}/g" \
    "$CFG_TEMPLATE" > "$CFG_OUT"

echo "Generated $CFG_OUT"
