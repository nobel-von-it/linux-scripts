#!/bin/sh

OS=$(./getos)

if [[ -z "$1" ]]
then
	echo "Not enough arguments"
	echo "Usage: ./remove-with-deps.sh <package_name>"
	exit 1
fi

PACKAGENAME=$1

case "$OS" in
	*"Arch"*)
		sudo pacman -Rns $PACKAGENAME
		sudo pacman -Rns $(pacman -Qdtq)
		sudo pacman -Sc
		sudo pacman -Syu
		sudo pacman -Dk
		sudo pacman -S --needed $(pacman -Qdtq)
		if ! paccache -r &>/dev/null
		then
			sudo pacman -S pacman-contrib
		fi
		paccache -r
		;;
	"Ubuntu")
		sudo apt-get purge $PACKAGENAME
		sudo apt-get purge $(apt-cache depends $PACKAGENAME | awk '{ print $2 }' | tr '\n' ' ')
		sudo apt-get autoremove
		sudo apt-get update
		sudo apt-get check
		sudo apt-get -f install
		sudo apt-get autoclean
		;;
	*)
		echo "Distro not support yet"
		exit 1
		;;
esac

echo "Done!"
