#!/usr/bin/env bash
# Copyright (C) 2023 Asaduzzaman "Asad" Pavel (https://iampavel.dev) <contact@iampavel.dev>
#
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_image_or_directory>"
    exit 1
fi
foreground_image_path="$1"

screenshot="/tmp/screenshot.png"
screenshot_blur="/tmp/screenshot_blur.png"
scrot -o "$screenshot"
convert "$screenshot" -filter Gaussian -scale 10% -scale 1000% -blur 0x8 "$screenshot_blur"

[ -e "$foreground_image_path" ] || \
    (echo "$foreground_image_path does not exist" && exit 1)
[ -f "$foreground_image_path" ] && \
    foreground="$foreground_image_path"
[ -d "$foreground_image_path" ] && \
    foreground=$(find "$foreground_image_path" -type f -name "*.png" | shuf -n 1)

if [ -e "$foreground" ]; then
    echo "Foreground image: $foreground"

    xrandr | grep -oP '(\S+) connected.*\d+x\d+\+\d+\+\d+' | while read -r monitor_position; do
        read -r monitor_width monitor_height monitor_x monitor_y <<< "$(echo "$monitor_position" | \
            awk '{print $NF}' | sed 's/[x+]/ /g')"

        read -r fg_original_width fg_original_height <<< "$(identify -format "%w %h" "$foreground")"

        x_pos=$(("($monitor_width - $fg_original_width) / 2 + $monitor_x"))
        y_pos=$(("($monitor_height - $fg_original_height) / 2 + $monitor_y"))
        case "$foreground" in
            *.bottom.png)
                x_pos=$(("($monitor_width - $fg_original_width) / 2 + $monitor_x"))
                y_pos=$(("$monitor_height + $monitor_y - $fg_original_height"))
                ;;
            *.right.png)
                x_pos=$(("$monitor_width + $monitor_x - $fg_original_width"))
                y_pos=$(("($monitor_height - $fg_original_height) / 2 + $monitor_y"))
                ;;
            *.left.png)
                x_pos=$(("$monitor_x"))
                y_pos=$(("($monitor_height - $fg_original_height) / 2 + $monitor_y"))
                ;;
            *.top-right.png)
                x_pos=$(("$monitor_width + $monitor_x - $fg_original_width"))
                y_pos=$(("$monitor_y"))
                ;;
            *.top-left.png)
                x_pos=$(("$monitor_x"))
                y_pos=$(("$monitor_y"))
                ;;
            *.bottom-right.png)
                x_pos=$(("$monitor_width + $monitor_x - $fg_original_width"))
                y_pos=$(("$monitor_height + $monitor_y - $fg_original_height"))
                ;;
            *.bottom-left.png)
                x_pos=$(("$monitor_x"))
                y_pos=$(("$monitor_height + $monitor_y - $fg_original_height"))
                ;;
        esac

        geometry="${fg_original_width}x${fg_original_height}+${x_pos}+${y_pos}"
        convert "$screenshot_blur" "$foreground" -geometry "$geometry" -composite "$screenshot_blur"
    done
fi

i3lock -n -f -e -t -i "$screenshot_blur"
