#!/usr/bin/fish

lsmod | grep -q btusb; or sudo modprobe btusb; and echo "Модуль загружен"; or echo "Ошибка загрузки"

sudo pacman -Suy bluez bluez-utils

sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service
