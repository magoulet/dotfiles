#!/usr/bin/env bash

options="⏾ Suspend\n⏼ Hibernate\n⟳ Reboot\n⏻ Shutdown\n⏻ Lock\n✗ Cancel"

selected=$(echo -e "$options" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/themes/power_menu)

case "$selected" in
  *Suspend)   systemctl suspend ;;
  *Hibernate) systemctl hibernate ;;
  *Reboot)    reboot ;;
  *Shutdown)  shutdown now ;;
  *Lock)      hyprlock ;;
  *Cancel)    exit 0 ;;
esac