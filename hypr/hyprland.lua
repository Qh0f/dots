-- Hyprland Lua config
-- https://wiki.hypr.land/Configuring/Start/

hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            -- Active window: slightly brighter steel gray/white than the waybar border
            active_border   = { colors = { "rgba(e5e1e9ee)", "rgba(928f99ee)" }, angle = 45 },
            -- Inactive window: matches waybar border color (#48454f) exactly
            inactive_border = "rgba(48454faa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },
    decoration = {
        rounding       = 12,   -- matches waybar pill rounding (12px)
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 12,
            render_power = 3,
            color        = 0xaa141318,  -- shadow tuned against waybar background color
        },
        blur = {
            enabled  = true,
            size     = 8,
            passes   = 2,
            vibrancy = 0.17,
        },
    },
    animations = {
        enabled = true,
    },
})
hl.layer_rule({
    name = "waybar-blur",
    match = { namespace = "^waybar$" },
    blur = true,
    ignore_alpha = 0,  -- 알파값 0인 픽셀을 무시(진짜 투명 처리) — 검은 사각형 방지 핵심
})

-- Curves & animations, see: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("md3_decel",    { type = "bezier", points = { {0.05, 0.7},   {0.1, 1.0} } })
hl.curve("md3_standard", { type = "bezier", points = { {0.2, 0.0},    {0.0, 1.0} } })
hl.curve("bounce",       { type = "bezier", points = { {0.175, 0.885},{0.32, 1.75} } })
hl.curve("linear",       { type = "bezier", points = { {0, 0},        {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5},    {0.75, 1} } })
hl.curve("quick",        { type = "bezier", points = { {0.15, 0},     {0.1, 1} } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 45, dampening = 18 })
hl.curve("bounce_out",   { type = "bezier", points = { {0.55, 0},     {0.1, 1.2} } })

hl.animation({ leaf = "global",        enabled = true, speed = 7.8,  bezier = "md3_decel" })
hl.animation({ leaf = "border",        enabled = true, speed = 8.4,  bezier = "md3_decel" })
hl.animation({ leaf = "windows",       enabled = true, speed = 1.5,    spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 3,    bezier = "bounce",     style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 2.2,  bezier = "bounce_out", style = "popin 90%" })
hl.animation({ leaf = "windowsMove",   enabled = true, speed = 4.65, bezier = "md3_standard" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 2.85, bezier = "md3_decel" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 2.35, bezier = "md3_decel" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.15, bezier = "md3_decel" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.95, bezier = "md3_decel" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4.2,  bezier = "md3_decel", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 2.75, bezier = "md3_decel", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.85, bezier = "md3_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.55, bezier = "md3_decel" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 4.55, bezier = "md3_decel", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 2.65, bezier = "md3_decel", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.4,  bezier = "md3_decel", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 6.35, bezier = "md3_decel" })
hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
    misc = {
        force_default_wallpaper = -1,     -- set to 0/1 to disable the default anime mascot wallpaper
        disable_hyprland_logo   = false,
        disable_splash_rendering = true
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))  -- dwindle only

-- Super + R: Rofi launcher
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd('rofi -show drun -modi "drun,window" -display-drun " Apps" -display-window " Windows" -theme "$HOME/.config/rofi/theme.rasi"'))
-- Super + Shift + X: Rofi power menu (uncomment if needed)
-- hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/rofi/powermenu/type-1/powermenu.sh"))

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("fcitx5 -r"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Focus movement
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Screenshot (region select)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | tee ~/Pictures/screenshot.png | wl-copy"))

-- Switch workspace / move window to workspace
for i = 1, 10 do
    local key = i % 10  -- map 10 to the 0 key
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(mainMod .. " + o",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + o", hl.dsp.window.move({ workspace = "special:magic" }))

-- Switch workspace via mouse scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize window with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    -- Ignore maximize requests from all apps
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix XWayland drag issue
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

------------------------------
---- AUTOSTART ----
------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("killall waybar; waybar &")
    hl.exec_cmd("fcitx5 -d --replace")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("swaync &")
    hl.exec_cmd("busctl call org.freedesktop.login1 /org/freedesktop/login1/session/self org.freedesktop.login1.Session Activate")
end)
