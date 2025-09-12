#!/bin/bash

EMAIL="maksimdavydenko12@gmail.com"
NAME="nobel-von-it"

echo "Configuring git"

git config --global user.email $EMAIL
git config --global user.name $NAME

echo "Done!"
