#!/bin/bash

DIR=$(dirname "$(realpath "$0")")

options=("all" "pacman" "aur")

selected=$(printf "%s\n" "${options[@]}" | fzf --multi --prompt="Choose installation process: " --bind=space:toggle+up)

if [ -n "$selected" ]; then
    echo "$selected" | while read -r option; do
        case $option in
            "pacman")
				yes | $DIR/pinstall.sh
				;;
			"aur")
				$DIR/ainstall.sh
				;;
			"all")
				yes | $DIR/pinstall.sh
				$DIR/ainstall.sh
				;;
        esac
    done
else
    echo "Interupted"
fi
