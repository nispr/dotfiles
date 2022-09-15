#!/usr/bin/env zsh

nvim --headless -c "PackerInstall" -c "qa"
nvim --headless -c "CocInstall coc-pyright" -c "qa"
