#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "Linking dotfiles from $DOTFILES_DIR to $CONFIG_DIR"

for dir in hypr rofi swaync waybar kitty; do
    if [ -e "$CONFIG_DIR/$dir" ] || [ -L "$CONFIG_DIR/$dir" ]; then
        echo "Backing up existing $dir to ${dir}.bak"
        mv "$CONFIG_DIR/$dir" "$CONFIG_DIR/${dir}.bak"
    fi
    ln -s "$DOTFILES_DIR/$dir" "$CONFIG_DIR/$dir"
    echo "Linked $dir"
done

# starship.toml is a single file, not a folder, so link it separately
if [ -e "$CONFIG_DIR/starship.toml" ] || [ -L "$CONFIG_DIR/starship.toml" ]; then
    echo "Backing up existing starship.toml to starship.toml.bak"
    mv "$CONFIG_DIR/starship.toml" "$CONFIG_DIR/starship.toml.bak"
fi
ln -s "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"
echo "Linked starship.toml"

echo "Generating kitty colors from wallpaper via pywal..."
if command -v wal >/dev/null 2>&1; then
    wal -i "$DOTFILES_DIR/wallpapers/wallpaper.jpg" -q
    echo "pywal colors generated (~/.cache/wal/colors-kitty.conf)"
else
    echo "WARNING: pywal not found. kitty.conf includes ~/.cache/wal/colors-kitty.conf,"
    echo "which won't exist until you install pywal and run:"
    echo "  wal -i $DOTFILES_DIR/wallpapers/wallpaper.jpg"
    echo "Until then, kitty may fail to start due to the missing include."
fi

echo "Done! Wallpaper is at $DOTFILES_DIR/wallpapers/wallpaper.jpg"
