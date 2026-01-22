#!/bin/bash

# Configuration
CONFIG_FILE="$HOME/.config/sway/config"
THEMES_DIR="$HOME/dotfiles/sway/.config/sway/themes"

change_wallpaper() {
    # 1. Detect current theme
    THEME=$(grep -oP "include themes/\K[^/]+" "$CONFIG_FILE" | head -n 1)

    if [ -z "$THEME" ]; then
        THEME="default"
    fi

    WALLPAPER_DIR="$THEMES_DIR/$THEME/wallpapers"
    CACHE_FILE="$HOME/.cache/sway_wallpaper_$THEME"

    if [ ! -d "$WALLPAPER_DIR" ]; then
        notify-send "Wallpaper Picker" "Wallpaper directory not found for theme: $THEME"
        exit 1
    fi

    # Handle Initialization vs Selection
    if [ "$1" == "--init" ]; then
        if [ -f "$CACHE_FILE" ]; then
            WALLPAPER=$(cat "$CACHE_FILE")
        else
            # Fallback to random if no cache exists
            WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | shuf -n 1)
        fi
        
        if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
            swaymsg "output * bg \"$WALLPAPER\" fill"
        fi
        exit 0
    fi

    # 2. Get the list of wallpapers (filenames only for wofi)
    mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -exec basename {} \;)

    if [ ${#WALLPAPERS[@]} -eq 0 ]; then
        notify-send "Wallpaper Picker" "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi

    # 3. Show wofi menu
    SELECTED=$(printf "%s\n" "${WALLPAPERS[@]}" | wofi --dmenu --prompt "Select Wallpaper:")

    if [ -n "$SELECTED" ]; then
        # 4. Set the wallpaper
        FULL_PATH="$WALLPAPER_DIR/$SELECTED"
        swaymsg "output * bg \"$FULL_PATH\" fill"
        
        # Store state for this specific theme
        mkdir -p "$(dirname "$CACHE_FILE")"
        echo "$FULL_PATH" > "$CACHE_FILE"
    fi
}

# Always run exactly once per invocation
change_wallpaper "$1"
