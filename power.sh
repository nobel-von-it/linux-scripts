
# 1
sudo pacman -S tlp tlp-rdw
sudo systemctl enable tlp.service
sudo systemctl start tlp.service

# Отключаем конфликтующие systemd сервисы
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket


# 2
sudo pacman -S thermald
sudo systemctl enable thermald.service
sudo systemctl start thermald.service

# 3
sudo pacman -S intel-ucode

# Обнови grub (если используешь grub)
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Или systemd-boot - добавь в /boot/loader/entries/*.conf строку:
# initrd /intel-ucode.img

# 4
sudo pacman -S powertop

# Калибровка (один раз, на батарее, займет 15 минут)
sudo powertop --calibrate
