#!/bin/bash
# Wallpaper rotator for Sway
# Uses centralized ~/dotfiles/themes/ structure

THEMES_DIR="$HOME/dotfiles/themes"
CURRENT_LINK="$THEMES_DIR/current"

change_wallpaper() {
    # Get current theme wallpaper directory
    WALLPAPER_DIR="$CURRENT_LINK/wallpapers"
    
    # Get theme name for cache file
    THEME_NAME=$(basename "$(readlink -f "$CURRENT_LINK")")
    CACHE_FILE="$HOME/.cache/sway_wallpaper_$THEME_NAME"

    if [ ! -d "$WALLPAPER_DIR" ]; then
        notify-send "Wallpaper Picker" "Wallpaper directory not found"
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

    # Get the list of wallpapers with image previews for wofi
    WOFI_LIST=""
    while IFS= read -r wallpaper; do
        filename=$(basename "$wallpaper")
        WOFI_LIST+="img:${wallpaper}:text:${filename}"$'\n'
    done < <(find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \))

    if [ -z "$WOFI_LIST" ]; then
        notify-send "Wallpaper Picker" "No wallpapers found"
        exit 1
    fi

    # Show wofi menu with image previews
    SELECTED=$(echo -e "$WOFI_LIST" | wofi --dmenu --prompt "Wallpaper:" --allow-images --cache-file=/dev/null -W 400 -I 48)

    if [ -n "$SELECTED" ]; then
        # Extract the full path from wofi output
        FULL_PATH=$(echo "$SELECTED" | sed 's/^img:\(.*\):text:.*$/\1/')
        
        swaymsg "output * bg \"$FULL_PATH\" fill"
        
        # Store state
        mkdir -p "$(dirname "$CACHE_FILE")"
        echo "$FULL_PATH" > "$CACHE_FILE"
    fi
}

change_wallpaper "$1"
