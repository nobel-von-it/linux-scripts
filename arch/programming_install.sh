#!/bin/bash

sudo pacman -Suy rustup python nodejs go

rustup default stable

echo "CARGO:"
cargo --version
echo ""

echo "PYTHON:"
python --version
echo ""

echo "NODE:"
node --version
echo ""

echo "GO:"
go version
echo ""
