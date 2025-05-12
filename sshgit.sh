#!/bin/bash

EMAIL="maksimdavydenko12@gmail.com"
NAME="nobel-von-it"

if [[ -z "$1" ]]; then
	read -p "Do you want to change default email? (y/n) " ans1
	if [[ "$ans1" = "y" ]]; then
		read -p "Write email: " email
		EMAIL=$email
	fi

	read -p "Do you want to change default name? (y/n) " ans2
	if [[ "$ans2" = "y" ]]; then
		read -p "Write name: " name
		NAME=$name
	fi

elif [[ ! "$1" = "d" ]]; then
	echo "Usage: ./sshgit.sh [d]"
	echo "  d for default configuration"
fi

echo "Creating ssh key"

ssh-keygen -t ed25519 -C "$EMAIL"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub

echo "Configuring git"

git config --global user.email $EMAIL
git config --global user.name $NAME

echo "Done!"
