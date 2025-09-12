#!/bin/bash

if [ ! -d "Aur" ]; then
	mkdir "Aur"
fi

cd Aur

# portproton
echo "Downloading portproton..."
git clone https://aur.archlinux.org/portproton.git
cd portproton
makepkg -sri
cd ..

# argagg
echo "Downloading appimagelauncher dependencies..."
git clone https://aur.archlinux.org/argagg.git
cd argagg
makepkg -sri
cd ..


# appimagelauncher
echo "Downloading appimagelauncher..."
git clone https://aur.archlinux.org/appimagelauncher.git
cd appimagelauncher
makepkg -sri
cd ..


read -p "GNOME? (y/n) " gnome
case "${gnome,,}" in
    y|yes)
		echo "Downloading extension-manager..."
		git clone https://aur.archlinux.org/extension-manager.git
		cd extension-manager
		makepkg -sri
		cd ..
        ;;
    n|no)
		echo "No GNOME detected."
        ;;
    *)
        echo "Damn. USE y/n"
		exit 1
        ;;
esac

read -p "DAVINCI? (y/n)" davinci
case "${davinci,,}" in
    y|yes)
		echo "Downloading davinci..."
		git clone https://aur.archlinux.org/davinci-resolve.git
		echo "Move downloaded davinci resolve (https://www.blackmagicdesign.com/products/davinciresolve) to aur directory"
		echo "Run makepkg -sri"
        ;;
    n|no)
		echo "Understood. Exit..."
        ;;
    *)
        echo "Damn. USE y/n"
		exit 1
        ;;
esac
