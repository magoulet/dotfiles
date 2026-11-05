---@diagnostic disable: undefined-global
local programs = require("programs")

local mainMod = "ALT"
-- local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal), { description = "Open terminal" })
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close(), { description = "Close window" })
closeWindowBind:set_enabled(true)
-- hl.bind(mainMod .. " + C", hl.dsp.close())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser), { description = "Open browser" })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"), { description = "Shutdown / exit Hyprland" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager), { description = "Open file manager" })
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating window" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Toggle fullscreen (maximized)" })
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(programs.menu), { description = "Launch apps (rofi drun)" })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudo-tiling" })
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only -- commented out to avoid conflict with vim focus keys

-- Screenshots
hl.bind("SHIFT + SUPER + 3", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'), { description = "Screenshot region (swappy)" })
hl.bind("SHIFT + SUPER + 4", hl.dsp.exec_cmd('grim - | swappy -f -'), { description = "Screenshot fullscreen (swappy)" })

-- Lock screen and menus
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })
hl.bind(mainMod .. " + X",         hl.dsp.exec_cmd("rofi -show power-menu -modi 'power-menu:rofi-power-menu --choices=suspend/lockscreen/logout/reboot/shutdown'"), { description = "Power menu" })
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("rofi -modi emoji -show emoji"), { description = "Emoji picker" })
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("pkill waybar && waybar"), { description = "Restart waybar" })

-- Cycle wallpapers from ~/Pictures/wallpapers via hypr-wallpaper.sh
hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd("/home/magoulet/.local/bin/hypr-wallpaper.sh next"), { description = "Next wallpaper" })
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("/home/magoulet/.local/bin/hypr-wallpaper.sh prev"), { description = "Previous wallpaper" })
-- hl.bind(mainMod .. " + CTRL + W",  hl.dsp.exec_cmd("/home/magoulet/.local/bin/hypr-wallpaper.sh random"))
hl.bind(mainMod .. " + SHIFT + P",  hl.dsp.exec_cmd("/home/magoulet/.local/bin/hypr-wallpaper.sh picker"), { description = "Pick wallpaper" })

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }), { description = "Focus down" })
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}), { description = "Focus workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
end

-- Move active workspace to next/previous monitor
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.workspace.move({ monitor = "+1" }), { description = "Move workspace to next monitor" })
hl.bind(mainMod .. " + SHIFT + bracketleft",  hl.dsp.workspace.move({ monitor = "-1" }), { description = "Move workspace to previous monitor" })

-- Rename active workspace
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.local/bin/hypr-rename-workspace.sh"), { description = "Rename current workspace" })

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"), { description = "Toggle scratchpad" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move window to scratchpad" })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace (scroll)" })
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace (scroll)" })

-- Alt+Tab workspace navigation
hl.bind("ALT + Tab",       hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace (alt-tab)" })
hl.bind("ALT + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace (alt-tab)" })

-- Move/resize windows with mainMod + LMB/RMB and dragging or with arrow keys
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, description = "Drag window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })
hl.bind(mainMod .. " + right", hl.dsp.window.resize({x = 20, y = 0, relative = true}), { repeating = true, description = "Resize window right" })
hl.bind(mainMod .. " + left", hl.dsp.window.resize({x = -20, y = 0, relative = true}), { repeating = true, description = "Resize window left" })
hl.bind(mainMod .. " + up", hl.dsp.window.resize({x = 0, y = -20, relative = true}), { repeating = true, description = "Resize window up" })
hl.bind(mainMod .. " + down", hl.dsp.window.resize({x = 0, y = 20, relative = true}), {repeating = true, description = "Resize window down" })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true, description = "Volume down" })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true, description = "Mute audio" })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true, description = "Mute microphone" })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true, description = "Brightness down" })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true, description = "Next track" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play / pause" })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play / pause" })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true, description = "Previous track" })

-- Hyprwhspr
hl.bind("SHIFT + ALT + D", hl.dsp.exec_cmd("/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh record"), { description = "Hyprwhspr: record screen" })

-- Keybinding cheatsheet
hl.bind("SUPER + SHIFT + slash", hl.dsp.exec_cmd("~/.local/bin/hypr-cheatsheet.sh"), { description = "Show keybinding cheatsheet" })