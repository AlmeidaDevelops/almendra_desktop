#!/bin/bash
# Theme selector for Sway using wofi
# Centralized theme system - updates all components from ~/dotfiles/themes/

THEMES_DIR="$HOME/dotfiles/themes"
CURRENT_LINK="$THEMES_DIR/current"
MAKO_CONFIG="$HOME/dotfiles/mako/.config/mako/config"
WAYBAR_CONFIG="$HOME/dotfiles/waybar/.config/waybar/config"

# Get list of themes (directory names, excluding 'current' symlink)
themes=$(ls -1 "$THEMES_DIR" | grep -v '^current$')

# Show wofi menu
selected=$(echo "$themes" | wofi --dmenu --prompt "Select Theme")

# Exit if nothing selected
[ -z "$selected" ] && exit 0

# Update symlink to point to selected theme
rm -f "$CURRENT_LINK"
ln -s "$THEMES_DIR/$selected" "$CURRENT_LINK"

# Copy mako config
if [ -f "$THEMES_DIR/$selected/mako.conf" ]; then
    cp "$THEMES_DIR/$selected/mako.conf" "$MAKO_CONFIG"
    makoctl reload 2>/dev/null
fi

# Update waybar workspace icons using jq
if [ -f "$THEMES_DIR/$selected/workspace-icons.json" ]; then
    ICONS=$(cat "$THEMES_DIR/$selected/workspace-icons.json")
    jq --argjson icons "$ICONS" '."sway/workspaces"."format-icons" = $icons' "$WAYBAR_CONFIG" > /tmp/waybar-config-tmp.json
    mv /tmp/waybar-config-tmp.json "$WAYBAR_CONFIG"
fi

# Reload sway (this reloads waybar too)
swaymsg reload

notify-send "Theme" "Changed to: $selected 🎨"
