return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'morhetz/gruvbox'

    -- Autoformat
    use 'vim-autoformat/vim-autoformat'

    -- fzf!
    use 'junegunn/fzf.vim'
    use 'junegunn/fzf'

    -- Git integration
    use 'tpope/vim-fugitive'

    -- File explorer pane
    -- use 'preservim/nerdtree'
    -- use 'Xuyuanp/nerdtree-git-plugin'

    use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}

    -- typescript support
    use 'leafgarland/typescript-vim'
    use 'peitalin/vim-jsx-typescript'
    use 'neoclide/coc-prettier'

    -- jump to pattern (press s{ab} to jump to ab)
    use 'justinmk/vim-sneak'

    use 'nvim-lua/lsp_extensions.nvim'

    -- Collection of common configurations for the Nvim LSP client
    use 'neovim/nvim-lspconfig'

    -- Snippet engine
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'

    -- To enable more of the features of rust-analyzer
    use 'simrat39/rust-tools.nvim'

    -- C++ support
    use 'octol/vim-cpp-enhanced-highlight'

    -- Diagnostics
    use 'dense-analysis/ale'

    -- PlantUML preview
    use 'weirongxu/plantuml-previewer.vim'
    use 'tyru/open-browser.vim'
    use 'aklt/plantuml-syntax'

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

    -- diagnostics
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                mode = "quickfix",
                auto_open = true, -- automatically open the list when you have diagnostics
                auto_close = true, -- automatically close the list when you have no diagnostics

            }
        end
    }
end)
