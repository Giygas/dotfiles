#!/bin/bash

# audio switcher for rofi
# handles device switching and moving streams

rofi_cmd="rofi -dmenu -theme ~/.config/rofi/NoSearchConfig.rasi"
current_sink=$(pactl get-default-sink)

# get sinks with names and descriptions
menu=$(pactl list sinks | awk '
/Name:/ {name=$2}
/Description:/ {
    desc="";
    for(i=2;i<=NF;i++) desc=desc $i " ";
    print name "|" desc
}
')

options=""
while IFS="|" read -r name desc; do
	if [ "$name" = "$current_sink" ]; then
		options+="● $desc\n"
	else
		options+="  $desc\n"
	fi
done <<<"$menu"

chosen=$(printf '%b' "$options" | $rofi_cmd -p "Audio Output")

# get the sink name back from the description
clean_choice="${chosen:2}"
sink=$(grep "$clean_choice" <<<"$menu" | cut -d"|" -f1)

if [ -n "$sink" ]; then
	pactl set-default-sink "$sink"

	# move existing streams to the new device
	pactl list short sink-inputs | awk '{print $1}' | while read -r input; do
		pactl move-sink-input "$input" "$sink"
	done
fi
