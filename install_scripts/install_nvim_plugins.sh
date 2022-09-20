#!/usr/bin/env zsh

nvim --headless -c "PackerInstall" -c "qa"

# Python LSP
nvim --headless -c "CocInstall coc-pyright" -c "qa"

# Snippet support 
nvim --headless -c "CocInstall coc-snippets" -c "qa"

# Diagnostics 
nvim --headless -c "CocInstall coc-diagnostic" -c "qa"

# VimScript LSP 
nvim --headless -c "CocInstall vim-language-server" -c "qa"

# Typescript LSP
nvim --headless -c "CocInstall coc-tsserver" -c "qa"
