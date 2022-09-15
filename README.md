# Dotfiles

Collection of simple dotfiles I use personally.

## Environment

This is written for MacOS, using `zsh` with `oh-my-zsh`, `neovim`, and sometimes `tmux`. Nothing fancy really. 

## Aliases

- `vim` actually opens [neovim](https://github.com/neovim/neovim)
- `vimf` uses [fzf](https://github.com/junegunn/fzf) to fuzzy-search a file to open with neovim
- `vimff filename` uses `fzf` from the current directory to fuzzy-search for `filename` and opens it in neovim
- `vimconfig`/`vimconf` opens `.config/nvim/init.vim` in neovim
- `vimplugs` opens the plugin bundling script for neovim
- `zshconfig`/`zshconf` opens `~/.zshrc` in neovim
- `gitg message` is short for `git add -A && git commit -m message"
- `gitgo message` is `gitg message` but also does a push
- `tigs` opens [tig](https://github.com/jonas/tig) status view
