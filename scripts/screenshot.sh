#!/bin/bash

# Directory to save screenshots
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# Timestamp for filename
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
FILENAME="$SAVE_DIR/screenshot_$TIMESTAMP.png"

# Mode: "full" or "select"
MODE=$1

if [ "$MODE" == "select" ]; then
    grim -g "$(slurp)" "$FILENAME"
else
    grim "$FILENAME"
fi

# Notify user
if [ -f "$FILENAME" ]; then
    notify-send "Screenshot saved" "$FILENAME" -i "$FILENAME"
fi
