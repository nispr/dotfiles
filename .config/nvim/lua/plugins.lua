return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'morhetz/gruvbox'

    -- File explorer pane
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'

    -- autoclose brackets
    use 'rstacruz/vim-closer'

    use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}

    use 'justinmk/vim-sneak'

    use 'nvim-lua/lsp_extensions.nvim'

    -- Collection of common configurations for the Nvim LSP client
    use 'neovim/nvim-lspconfig'

    -- Completion framework
    use 'hrsh7th/nvim-cmp'

    -- LSP completion source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'

    -- Other useful completion sources
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'tamago324/cmp-zsh'

    -- Snippet engine
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'

    -- To enable more of the features of rust-analyzer
    use 'simrat39/rust-tools.nvim'

    use 'octol/vim-cpp-enhanced-highlight'

    -- Fuzzy finder
    -- Optional
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Theme
    use 'arcticicestudio/nord-vim'

    -- LaTeX support
    use 'lervag/vimtex'

    -- Markdown Preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
end)
