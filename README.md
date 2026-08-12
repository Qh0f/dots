# 🌙 my hyprland rice

Personal Hyprland setup on Arch Linux. Cold gray-blue, near-monochrome theme,
Lua-based Hyprland config with per-animation tuning, a segmented Waybar, a
redesigned SwayNC, and a combi-mode Rofi launcher.

---

## 📸 Preview

![screenshot](screenshots/1.webp)

![screenshot](screenshots/2.webp)

https://github.com/user-attachments/assets/3dff2526-f1d6-498d-b956-92a99cb71bfe

---

## 🖥️ Stack

| Component      | Tool                                    |
| --------------- | ---------------------------------------- |
| OS             | Arch Linux                                |
| WM             | Hyprland (Lua config, `hyprland.lua`)    |
| Bar            | Waybar                                    |
| Launcher       | Rofi (combi mode — Apps + Windows tabs)  |
| Notifications  | SwayNC                                    |
| Terminal       | Kitty + pywal (dynamic colors)           |
| Prompt         | Starship                                  |
| Wallpaper      | Hyprpaper                                 |
| Icons          | Papirus-Dark                              |
| Font           | JetBrainsMono Nerd Font                  |
| Input method   | fcitx5                                    |

---

## 📁 Structure

```
dotfiles/
├── hypr/
│   ├── hyprland.lua        # main config: binds, animations, rules
│   └── hyprpaper.conf      # wallpaper daemon config
├── waybar/
│   ├── config.jsonc        # modules, layout, workspace range
│   └── style.css           # segmented stats group, colors
├── rofi/
│   ├── config.rasi         # global rofi options
│   ├── theme.rasi          # color palette, widget styling
│   └── launchers/asdf/
│       └── launcher.sh     # combi-mode launcher script (bound to SUPER+R)
├── swaync/
│   ├── config.json         # widget order, power-dock buttons
│   ├── style.css           # MPRIS hero card, pill dock, notification cards
│   └── scripts/
│       └── record-toggle.sh # screen recording toggle (wf-recorder)
├── kitty/
│   └── kitty.conf          # terminal config, pywal include
├── starship/
│   └── starship.toml       # prompt config
├── wallpapers/
│   └── wallpaper.jpg
├── install.sh
└── README.md
```

---
### Dependencies

```bash
# Core
sudo pacman -S hyprland waybar rofi-wayland kitty starship hyprpaper \
               papirus-icon-theme ttf-jetbrains-mono-nerd fcitx5 \
               cava wf-recorder python-pywal

# Utilities used by keybinds/scripts
sudo pacman -S grim slurp wl-clipboard playerctl brightnessctl \
               wireplumber thunar

# SwayNC (AUR)
yay -S swaync
```

## 🚀 Install

```bash
git clone https://github.com/Qh0f/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` symlinks each folder (`hypr`, `rofi`, `swaync`, `waybar`, `kitty`)
and `starship.toml` into `~/.config/`, backing up anything that already
exists there (`*.bak`). It also runs pywal against the bundled wallpaper so
Kitty has colors on first launch.

---

## ⌨️ Keybindings

Main modifier is `SUPER`.

### Apps & launcher

| Keybind      | Action                              |
| ------------- | ------------------------------------ |
| `SUPER + Q`  | Open terminal (Kitty)               |
| `SUPER + E`  | Open file manager (Thunar)          |
| `SUPER + R`  | App launcher (Rofi, combi: Apps + Windows tabs) |
| `SUPER + N`  | Toggle notification center (SwayNC) |
| `SUPER + D`  | Restart input method (fcitx5)       |

### Window management

| Keybind              | Action                        |
| ---------------------- | ------------------------------ |
| `SUPER + C`           | Close active window            |
| `SUPER + V`           | Toggle floating                |
| `SUPER + P`           | Toggle pseudo-tile             |
| `SUPER + J`           | Toggle split direction (dwindle) |
| `SUPER + arrow keys`  | Move focus                     |
| `SUPER + LMB drag`    | Move window                    |
| `SUPER + RMB drag`    | Resize window                  |

### Workspaces

| Keybind                 | Action                          |
| ------------------------- | -------------------------------- |
| `SUPER + [0-9]`          | Switch to workspace 1–10        |
| `SUPER + SHIFT + [0-9]`  | Move active window to workspace |
| `SUPER + scroll`         | Cycle through workspaces         |
| `SUPER + O`              | Toggle scratchpad ("magic")     |
| `SUPER + SHIFT + O`      | Move window to scratchpad        |

### System

| Keybind              | Action                              |
| ---------------------- | ------------------------------------ |
| `SUPER + M`           | Exit session (hyprshutdown, or `hl.dsp.exit()` as fallback) |
| `SUPER + SHIFT + S`   | Screenshot area (grim + slurp → clipboard + `~/Pictures`) |

### Notification center dock (SwayNC pill buttons)

| Button       | Action                          |
| ------------- | -------------------------------- |
| Power        | `systemctl poweroff`             |
| Reboot       | `systemctl reboot`               |
| Logout       | `hl.dsp.exit()` (ends Hyprland session) |
| Record       | Toggle screen recording (wf-recorder → `~/Videos`) |

---

## ✨ Features

**Hyprland**
- Lua config (`hyprland.lua`) with per-leaf animation tuning instead of one
  global default — separate bezier/spring curves for window open
  (`windowsIn`, overshoot bounce), close (`windowsOut`, different bounce),
  move (`windowsMove`, snappy), and workspace switching (`md3_decel`, slide).
- Custom spring physics curve (`easy`) used for window resizing.
- Blur + shadow tuned to match the Waybar background tone.

**Waybar**
- Clock (left, seconds, click to toggle date format) → Workspaces (center,
  1–10) → Window title + grouped stats + tray (right).
- CPU / memory / network / volume / battery are wrapped in a single
  connected segment (`group/stats`) instead of separate floating pills —
  first/last module rounded, dividers between.

**Rofi**
- Combi mode: Apps and Windows in one launcher with a tab switcher
  (`mode-switcher`), instead of a single flat list.

**SwayNC**
- Widget order: MPRIS (now-playing) as a hero card up top, then
  notifications, then a pill-shaped button dock (power/reboot/logout/record)
  at the bottom — instead of the default stacked layout.
- Fixed a rendering bug where the control-center background wasn't
  transparent.
- Icon-forward notification cards with rounded corners and circular
  close buttons.

**Terminal**
- Kitty + pywal: colors regenerate from the current wallpaper
  (`wal -i <wallpaper> -q`), independent of the rest of the system palette.

---

## 🤖 Credits

Vive coded with clode
