#!/bin/bash

cd $HOME/Downloads/Git

git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git

echo "strategy=general_alt2.bat
auto_update=false
interface=enp5s0" > env.conf

echo "NOW UPDATE SUDOERS"
echo ""
echo "After use:"
echo "sudo $HOME/Downloads/Git/zapret-discord-youtube-linux/main_script.sh -nointeractive"
echo ""
echo "Also create autostart service"
