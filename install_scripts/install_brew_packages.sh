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

brew install $ios $general $networking $creative $utility
