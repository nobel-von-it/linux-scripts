#!/bin/bash

OS=$(./getos)

case "$OS" in
    *"Arch"*)
        if pacman -Q &>/dev/null
        then
            echo "Rustup already installed in system"
        else 
            yes | sudo pacman -Suy rustup
        fi
        ;;
    "Ubuntu")
        if dpkg -s rustup &>/dev/null
        then
            echo "Rustup already installed in system"
        else
            sudo apt update && sudo apt upgrade -y
            sudo apt install rustup -y
        fi
        ;;
    *)
        echo "Distro not support yet"
        exit 1
        ;;

esac

rustup default stable
rustup component add rust-analyzer
