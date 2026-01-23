#!/bin/bash
# waybar_emoji.sh - Helper for Waybar emoji modules

# Map digits to keycap emojis
to_emoji() {
    echo "$1" | sed \
        -e 's/0/0️⃣/g' \
        -e 's/1/1️⃣/g' \
        -e 's/2/2️⃣/g' \
        -e 's/3/3️⃣/g' \
        -e 's/4/4️⃣/g' \
        -e 's/5/5️⃣/g' \
        -e 's/6/6️⃣/g' \
        -e 's/7/7️⃣/g' \
        -e 's/8/8️⃣/g' \
        -e 's/9/9️⃣/g' \
        -e 's/%/📈/g' \
        -e 's/:/🕒/g'
}

case "$1" in
    "clock")
        to_emoji "$(date +'%H:%M')"
        ;;
    "battery")
        cap=$(cat /sys/class/power_supply/BAT0/capacity)
        status=$(cat /sys/class/power_supply/BAT0/status)
        icon="🔋"
        [ "$status" = "Charging" ] && icon="⚡"
        echo "$icon $(to_emoji "$cap📈")"
        ;;
    "volume")
        vol=$(pamixer --get-volume)
        mute=$(pamixer --get-mute)
        icon="🔊"
        [ "$mute" = "true" ] && echo "🔇 Muted" && exit 0
        echo "$icon $(to_emoji "$vol📈")"
        ;;
    "backlight")
        perc=$(brightnessctl -m | cut -d, -f4 | tr -d '%')
        echo "💡 $(to_emoji "$perc📈")"
        ;;
esac
