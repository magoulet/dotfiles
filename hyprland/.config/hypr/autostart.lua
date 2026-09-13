---@diagnostic disable: undefined-global
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("gammastep-indicator")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("awww img -o eDP-1 \"/home/magoulet/Pictures/wallpapers/1-sunset-lake.png\"")
  hl.exec_cmd("awww img -o DP-1 \"/home/magoulet/Pictures/wallpapers/1-city-view.png\"")
  hl.exec_cmd("awww img -o DP-2 \"/usr/share/hypr/wall2.png\"")
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
end)


