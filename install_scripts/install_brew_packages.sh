#!/usr/bin/env bash
DIR="${0%/*}"

if [ ! $(command -v brew) ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew tap homebrew/command-not-found

ios=$(echo -e ""\
    "carthage"\
    "cocoapods"\
)

general=$(echo -e ""\
    "broot"\
    "coreutils"\
    "dbus"\
    "ddate"\
    "fzf"\
    "gawk"\
    "gh"\
    "htop"\
    "jenv"\
    "neovim"\
    "node"\
    "ripgrep"\
    "ruby"\
    "tig"\
    "tmux"\
    "zsh-syntax-highlighting"\
)

networking=$(echo -e ""\
    "httpie"
)

creative=$(echo -e ""\
    "hugo"
)

utility=$(echo -e ""\
    "googler"\
    "lastpass-cli"\
    "texlive"\
    "thefuck"
)

echo "Installing brew packages"
brew install $ios $general $networking $creative $utility

echo "Installing skim" # for vimtex
brew install --cask skim