return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'morhetz/gruvbox'
	use 'preservim/nerdtree'
	use 'Xuyuanp/nerdtree-git-plugin'
	use 'rstacruz/vim-closer'
	use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}

	use 'justinmk/vim-sneak'

	-- rust
	use 'nvim-lua/lsp_extensions.nvim'
	-- Collection of common configurations for the Nvim LSP client
	use 'neovim/nvim-lspconfig'

	-- Completion framework
	use 'hrsh7th/nvim-cmp'

	-- LSP completion source for nvim-cmp
	use 'hrsh7th/cmp-nvim-lsp'

	-- Snippet completion source for nvim-cmp
	use 'hrsh7th/cmp-vsnip'

	-- Other usefull completion sources
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'

	-- See hrsh7th's other plugins for more completion sources!

	-- To enable more of the features of rust-analyzer, such as inlay hints and more!
	use 'simrat39/rust-tools.nvim'

	-- Snippet engine
	use 'hrsh7th/vim-vsnip'

	-- Fuzzy finder
	-- Optional
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	-- Color scheme used in the GIFs!
	use 'arcticicestudio/nord-vim'

	use({
    		"iamcco/markdown-preview.nvim",
    		run = function() vim.fn["mkdp#util#install"]() end,
	})
end)
