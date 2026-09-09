#!/usr/bin/env bash

# Cycle wallpapers from ~/Pictures/wallpapers via awww
#
# Usage:
#   hypr-wallpaper.sh [next|prev|random|list|picker|set <name>]
#
#   (no args)    cycle to the next wallpaper
#   next         cycle forward
#   prev         cycle backward
#   random       pick a random wallpaper
#   list         print the wallpapers, marking the current one
#   picker       choose a wallpaper in rofi (with thumbnail previews)
#   set <name>   set a specific wallpaper by filename
#
# The current selection is stored in $XDG_CACHE_HOME/hypr-wallpaper-current
# so cycling wraps around and survives restarts.

WALL_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
STATE_FILE="$CACHE_DIR/hypr-wallpaper-current"

usage() {
    sed -n '2,14p' "$0" | sed 's/^# \{0,1\}//'
    exit 1
}

# shellcheck disable=SC2207
mapfile -d '' images < <(find "$WALL_DIR" -maxdepth 1 \( -type f -o -type l \) \( \
    -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \
    -o -iname '*.gif' -o -iname '*.webp' \) -printf '%f\0' | sort -z)

if [ "${#images[@]}" -eq 0 ]; then
    echo "No images found in $WALL_DIR" >&2
    exit 1
fi

current=""
[ -f "$STATE_FILE" ] && current="$(cat "$STATE_FILE")"

cmd="${1:-next}"
target=""

case "$cmd" in
    list)
        for img in "${images[@]}"; do
            marker="  "
            [ "$img" = "$current" ] && marker="> "
            printf '%s%s\n' "$marker" "$img"
        done
        exit 0
        ;;
    set)
        [ -z "$2" ] && usage
        target="$2"
        ;;
    next|prev)
        idx=-1
        for i in "${!images[@]}"; do
            [ "${images[$i]}" = "$current" ] && idx=$i && break
        done
        if [ "$idx" -lt 0 ]; then
            target="${images[0]}"
        elif [ "$cmd" = "next" ]; then
            target="${images[$(((idx + 1) % ${#images[@]}))]}"
        else
            target="${images[$(((idx - 1 + ${#images[@]}) % ${#images[@]}))]}"
        fi
        ;;
    random)
        target="${images[$((RANDOM % ${#images[@]}))]}"
        ;;
    picker)
        idx=-1
        for i in "${!images[@]}"; do
            [ "${images[$i]}" = "$current" ] && idx=$i && break
        done
        rofi_args=(-dmenu -i -p "Wallpaper" -sync -show-icons)
        [ "$idx" -ge 0 ] && rofi_args+=(-a "$idx")
        selected=$(
            for img in "${images[@]}"; do
                printf '%s\0icon\x1fthumbnail://%s\n' "$img" "$WALL_DIR/$img"
            done | rofi "${rofi_args[@]}"
        )
        [ $? -ne 0 ] && exit 0
        target="$selected"
        ;;
    *)
        usage
        ;;
esac

full="$WALL_DIR/$target"
if [ ! -f "$full" ]; then
    echo "Image not found: $full" >&2
    exit 1
fi

mkdir -p "$CACHE_DIR"
printf '%s\n' "$target" > "$STATE_FILE"

# Already showing this wallpaper? Nothing to do.
[ "$target" = "$current" ] && exit 0

awww img -a --transition-type random "$full"