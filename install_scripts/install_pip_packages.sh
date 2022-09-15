#!/usr/bin/env zsh

if [ $(command -v pip3) -ne 0 ]; then
    echo "Pip3 not found, aborting."
    exit 1
fi

pip3 install python-language-server

# Required for nvim-ultisnips
pip3 install neovim
