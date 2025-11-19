#!/bin/bash

cd $HOME/Downloads/Aur

git clone https://aur.archlinux.org/paru.git

cd paru

makepkg -sri

paru -S v2rayn
paru -S portproton
paru -S python-inquirer
paru -S ente-auth-bin
