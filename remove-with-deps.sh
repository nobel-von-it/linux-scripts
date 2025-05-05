#!/bin/sh

if [ -z "$1" ] 
then
	echo "No args, need at least one"
	exit 1
fi

PACKAGENAME=$1


sudo apt-get purge $PACKAGENAME
sudo apt-get purge $(apt-cache depends $PACKAGENAME | awk '{ print $2 }' | tr '\n' ' ')
sudo apt-get autoremove
sudo apt-get update
sudo apt-get check
sudo apt-get -f install
sudo apt-get autoclean
