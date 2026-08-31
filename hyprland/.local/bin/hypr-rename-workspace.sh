#!/usr/bin/env bash

# Fetch current active workspace info
ws_json=$(hyprctl activeworkspace -j)
ws_id=$(echo "$ws_json" | jq -r '.id')
ws_name=$(echo "$ws_json" | jq -r '.name')

# Prompt user for new workspace name via rofi
new_name=$(echo "" | rofi -dmenu -p "Workspace $ws_id" -mesg "Current: $ws_name (press Enter empty to reset)")
ret=$?

# If user cancelled with Esc
if [ $ret -ne 0 ]; then
    exit 0
fi

# If blank, reset to numeric ID
if [ -z "$new_name" ]; then
    new_name="$ws_id"
fi

# Dispatch rename in Hyprland
hyprctl dispatch "hl.dsp.workspace.rename{workspace = $ws_id, name = \"$new_name\"}"
