#!/bin/bash

EMAIL="maksimdavydenko12@gmail.com"

echo "Do you want to change default email $EMAIL? (y/n)"
read -r ans

if [[ "$ans" = "y" ]]
then
    echo "Write email: "
    read -r email
    EMAIL=$email
fi

echo "Creating ssh key"

ssh-keygen -t ed25519 -C "$EMAIL"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
