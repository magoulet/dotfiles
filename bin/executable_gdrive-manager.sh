#!/bin/bash

# gdrive-manager.sh - Simple Google Drive mount manager
# Usage: gdrive-manager.sh [mount|umount|status|help]

MOUNT_POINT="/mnt/gdrive"
CACHE_DIR="$HOME/.cache/rclone"

mount_drive() {
    mkdir -p "$MOUNT_POINT"
    mkdir -p "$CACHE_DIR"

    echo "Mounting Google Drive to $MOUNT_POINT..."
    rclone mount gdrive: "$MOUNT_POINT" \
        --buffer-size 32M \
        --dir-cache-time 72h \
        --drive-chunk-size 16M \
        --cache-dir "$CACHE_DIR" \
        --vfs-cache-mode full \
        --vfs-cache-max-size 50G \
        --vfs-cache-max-age 120h \
        --vfs-read-chunk-size 128M \
        --vfs-read-chunk-size-limit 1G \
        --drive-export-formats=.link.html \
        --daemon

    sleep 2
    check_status
}

umount_drive() {
    if mountpoint -q "$MOUNT_POINT"; then
        echo "Unmounting Google Drive from $MOUNT_POINT..."
        fusermount -uz "$MOUNT_POINT"
        echo "Google Drive unmounted successfully."
    else
        echo "Google Drive is not currently mounted."
    fi
}

check_status() {
    if mountpoint -q "$MOUNT_POINT"; then
        echo "Google Drive is mounted at $MOUNT_POINT"
        echo "Cache location: $CACHE_DIR"
        echo "Used space:"
        df -h "$MOUNT_POINT" | tail -n 1
    else
        echo "Google Drive is not currently mounted."
    fi
}

show_help() {
    echo "Google Drive Manager"
    echo "Usage: $(basename "$0") [command]"
    echo ""
    echo "Commands:"
    echo "  mount   - Mount Google Drive"
    echo "  umount  - Unmount Google Drive"
    echo "  status  - Check mount status"
    echo "  help    - Show this help message"
    echo ""
    echo "If no command is given, status is shown."
}

# Main command processing
case "$1" in
    mount)
        mount_drive
        ;;
    umount|unmount)
        umount_drive
        ;;
    status)
        check_status
        ;;
    help|-h|--help)
        show_help
        ;;
    "")
        check_status
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        exit 1
        ;;
esac

exit 0
