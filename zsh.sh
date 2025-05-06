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

case "$OS" in
    "Arch")
        yes | sudo pacman -Suy zsh
        ;;
    "Ubuntu")
        sudo apt update && sudo apt upgrade -y
        sudo apt install zsh
        ;;
    *)
        echo "Distro not support yet"
        exit 1
        ;;


sudo pacman -S zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
