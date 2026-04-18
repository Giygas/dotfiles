#!/bin/bash

# simple rofi power menu
# handles basic system control and a poweroff timer

dir="$HOME/.config/rofi"
[ ! -d "$dir" ] && dir="$(dirname "$(readlink -f "$0")")/.."
rofi_cmd="rofi -dmenu -i -p Power -theme $dir/NoSearchConfig.rasi"

actions="󰐥 Poweroff\n󰜉 Reboot\n󰤄 Suspend\n󰈆 Logout\n󱎫 Poweroff Timer"

show_timer_menu() {
	printf "󱎫  5 mins\n󱎫  10 mins\n󱎫  15 mins\n󱎫  30 mins\n󱎫  45 mins\n󱎫  1 hr" | $rofi_cmd
}

selection=$(printf '%b' "$actions" | $rofi_cmd)

case "$selection" in
*Poweroff) systemctl poweroff ;;
*Reboot) systemctl reboot ;;
*Suspend) systemctl suspend ;;
*Logout) hyprctl dispatch exit ;;
*"Poweroff Timer")
	timer_choice=$(show_timer_menu)
	case "$timer_choice" in
	*"45 mins") m=45 ;;
	*"30 mins") m=30 ;;
	*"15 mins") m=15 ;;
	*"10 mins") m=10 ;;
	*"5 mins") m=5 ;;
	*"1 hr") m=60 ;;
	esac

	if [ -n "$m" ]; then
		shutdown +"$m"
		notify-send "Poweroff Timer" "System will power off in $m mins"
	fi
	;;
esac
