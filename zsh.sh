#!/bin/bash

OS=$(./getos)

case "$OS" in
    *"Arch"*)
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
esac

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
