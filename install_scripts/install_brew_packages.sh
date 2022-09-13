#!/usr/bin/env bash
DIR="${0%/*}"

if [ ! $(command -v brew) ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install mas

brew bundle --file ./Brewfile
