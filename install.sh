#/!usr/bin/env zsh
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
sudo xcodebuild -runFirstLaunch

echo "Installing brew packages..."
./install_scripts/install_brew_packages.sh

echo "Installing npm packages..."
./install_scripts/install_npm_packages.sh

echo "Installing pip packages..."
./install_scripts/install_pip_packages.sh

echo "Setting up nvim..."
./install_scripts/install_nvim_plugins.sh

instructions=$(cat <<EOF 
Installations done. Things to do manually:
    - Stop Spotlight from indexing external hard drives.
    - Setup inverse search in Skim (PDF Viewer). From the vimtex
      manual: Open the "Sync" tab in the settings panel in Skim 
      and set it to "Custom". The command should be the like 
      nvim --headless -c "VimtexInverseSearch %line '%file'"
EOF)

echo "${instructions}"
