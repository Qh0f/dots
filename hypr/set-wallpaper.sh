#!/usr/bin/env bash
## Set wallpaper + regenerate dynamic color palette for kitty, waybar, swaync, rofi
set -e

WALLPAPER="$1"
if [ -z "$WALLPAPER" ]; then
    echo "Usage: set-wallpaper.sh /path/to/image.jpg"
    exit 1
fi

# Regenerate palette (also writes colors-kitty.conf, colors-waybar.css, etc.
# from ~/.config/wal/templates/ into ~/.cache/wal/)
wal -i "$WALLPAPER" -q

# Swap the actual wallpaper via hyprpaper IPC
hyprctl hyprpaper reload ,"$WALLPAPER"# Reload bar + notification center so they pick up the new @import'd colors
killall waybar; waybar &
swaync-client --reload-css

echo "Wallpaper + palette updated: $WALLPAPER"
