#!/bin/bash
# Media Control Debounce Script
# Prevents multiple triggers from a single scroll gesture (motion)

ACTION=$1
LOCKFILE="/tmp/media_debounce.lock"
INTERVAL=0.5 # 500ms debounce interval

# Get current time in seconds with decimals
NOW=$(date +%s.%N)

if [ -f "$LOCKFILE" ]; then
    LAST_TIME=$(cat "$LOCKFILE")
    DIFF=$(echo "$NOW - $LAST_TIME" | bc)
    
    # If the time difference is less than the interval, ignore the action
    if (( $(echo "$DIFF < $INTERVAL" | bc -l) )); then
        exit 0
    fi
fi

# Store current time and execute action
echo "$NOW" > "$LOCKFILE"
playerctl "$ACTION"
