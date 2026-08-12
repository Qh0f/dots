#!/usr/bin/env bash
## Toggle screen recording with wf-recorder

mkdir -p "$HOME/Videos"

if pgrep -x wf-recorder > /dev/null; then
    pkill -INT -x wf-recorder
    notify-send "Recording stopped" "Saved to ~/Videos"
else
    filename="$HOME/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4"
    wf-recorder -f "$filename" &
    notify-send "Recording started" "$filename"
fi
