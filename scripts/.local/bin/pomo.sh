#!/bin/sh

COUNT=0

FOCUS_MIN=${1:-25}
BREAK_MIN=${2:-5}
LONG_BREAK_MIN=${3:-15}

FOCUS_SEC=$((FOCUS_MIN * 60))
BREAK_SEC=$((BREAK_MIN * 60))
LONG_BREAK_SEC=$((LONG_BREAK_MIN * 60))

trap 'notify-send "🍅 Timer closed" "Goodbye!" && pw-play /usr/share/sounds/freedesktop/stereo/message.oga; exit 1' INT

while true; do
    COUNT=$((COUNT + 1))

    notify-send "🍅 Focus session #$COUNT" "$FOCUS_MIN minute session" && pw-play /usr/share/sounds/freedesktop/stereo/message.oga
    sleep "$FOCUS_SEC"

    if [ $((COUNT % 4)) -eq 0 ]; then
        notify-send "🍅 Long break" "$LONG_BREAK_MIN minute break" && pw-play /usr/share/sounds/freedesktop/stereo/complete.oga
        sleep "$LONG_BREAK_SEC"
    else
        notify-send "🍅 Take a break" "$BREAK_MIN minute break" && pw-play /usr/share/sounds/freedesktop/stereo/complete.oga
        sleep "$BREAK_SEC"
    fi
done
