#!/bin/bash

# Icons
# User requested specific FontAwesome icons
ICON_PLAY=$'\uf144'  # fa-circle-play (Solid)
ICON_PAUSE=$'\uf28b' # fa-circle-pause (Solid)

# Loop to handle events
# Using tab as delimiter to avoid issues with :: appearing in metadata
playerctl metadata --format $'{{status}}\t{{artist}}\t{{title}}' --follow | while IFS=$'\t' read -r status artist title; do
    # Fallback
    if [ -z "$status" ]; then
        status=$(playerctl status 2>/dev/null)
        artist=$(playerctl metadata artist 2>/dev/null)
        title=$(playerctl metadata title 2>/dev/null)
    fi

    if [ "$status" == "Playing" ]; then
        icon="$ICON_PLAY"
        class="playing"
    elif [ "$status" == "Paused" ]; then
        icon="$ICON_PAUSE"
        class="paused"
    else
        echo '{"text": "", "class": "stopped"}'
        continue
    fi
    
    # Truncate Artist (Max 15)
    if [ ${#artist} -gt 15 ]; then
        disp_artist="${artist:0:15}..."
    else
        disp_artist="$artist"
    fi
    
    # Truncate Title (Max 20)
    if [ ${#title} -gt 20 ]; then
        disp_title="${title:0:20}..."
    else
        disp_title="$title"
    fi
    
    # FIXED WIDTH ICON PADDING
    # This ensures the text always starts at the same position
    # regardless of the icon width.
    padded_icon=$(printf "%-3s" "$icon")
    
    TEXT="$padded_icon $disp_artist - $disp_title"
    TEXT=$(echo "$TEXT" | sed 's/"/\\"/g')
    ALT="$status: $artist - $title"
    ALT=$(echo "$ALT" | sed 's/"/\\"/g')

    echo "{\"text\": \"$TEXT\", \"class\": \"$class\", \"alt\": \"$ALT\", \"tooltip\": \"$ALT\"}"
done
