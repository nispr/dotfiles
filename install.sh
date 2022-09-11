#/!usr/bin/env bash
# 
# Installs symbolic links to dotfiles and installs 
# specified binaries.
#

DIR="${0%/*}"

echo "Starting installation."

# TODO: Check for existing files.
ln -s "$HOME/.zshrc" "$DIR/.zshrc"
ln -s "$HOME/.config/nvim" "$DIR/.config/nvim"

xcode-select --install
echo "Installing brew packages..."
./install_scripts/install_brew_packages.sh

echo "Installing npm packages..."
./install_scripts/install_npm_packages.sh
