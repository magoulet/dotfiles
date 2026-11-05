#!/usr/bin/env bash
# Display-only cheatsheet of described Hyprland keybindings, via rofi.
# The descriptions come from the `description = "..."` option on each
# hl.bind() in ~/.config/hypr/keybindings.lua and are read at runtime
# from `hyprctl binds -j`, so this can never drift from the config.
# Bound to: SUPER + SHIFT + /
set -euo pipefail

# modmask bits (SHIFT=1, CTRL=4, ALT=8, SUPER=64) are decoded with integer
# arithmetic since jq 1.8 dropped the bitwise operators.
hyprctl binds -j | jq -r '
  def combo:
    (if (.modmask / 64 | floor) % 2 == 1 then "SUPER + " else "" end) +
    (if (.modmask / 8  | floor) % 2 == 1 then "ALT + "   else "" end) +
    (if (.modmask / 4  | floor) % 2 == 1 then "CTRL + "  else "" end) +
    (if (.modmask / 1  | floor) % 2 == 1 then "SHIFT + " else "" end) +
    .key;
  .[]
  | select(.has_description)
  | "\(combo)\t\(.description)"
' | sort -f | column -t -s $'\t' | rofi -dmenu -i -no-custom -p "Keybindings"