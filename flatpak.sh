#!/bin/bash

OS=
VER=

if [[ -f /etc/os-release ]]
then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1
then
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [[ -f /etc/lsb-release ]]
then
    OS=Debian
    VER=$(cat /etc/debian_version)
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

echo "Detected OS $OS:$VER. Right? (y/n)"
read -r ans

if [[ ! "$ans" = "y" ]] 
then
    echo "Bruh! I don't know"
    exit 1
fi

if [[ "$OS" = "Ubuntu" ]]
then
    sudo apt update && sudo apt upgrade -y
    sudo apt install flatpak -y
elif [[ "$OS" = "Arch" ]]
then
    yes | sudo pacman -Suy flatpak
else 
    echo "Dont support yet"
fi

echo "Do you want to install deafult packages from flatpa? (y/n)"
read -r ans

if [[ ! "$ans" = "y" ]]
then
    # Choosing not support yet
    echo "Ok"
    exit 1
fi

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y --noninteractive org.videolan.VLC
flatpak install -y --noninteractive com.valvesoftware.Steam
flatpak install -y --noninteractive md.obsidian.Obsidian
flatpak install -y --noninteractive com.obsproject.Studio
flatpak install -y --noninteractive io.gitlab.zehkira.Monophony
flatpak install -y --noninteractive org.gimp.GIMP
flatpak install -y --noninteractive net.ankiweb.Anki
flatpak install -y --noninteractive com.discordapp.Discord
flatpak install -y --noninteractive flathub portproton
flatpak install -y --noninteractive org.qbittorrent.qBittorrent
flatpak install -y --noninteractive com.mattjakeman.ExtensionManager
