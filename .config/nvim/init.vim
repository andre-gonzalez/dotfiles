""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		call plug#begin()

				"Set a infomative line in the bottom of the editor
				Plug 'vim-airline/vim-airline'

				"Themes for airline
				Plug 'vim-airline/vim-airline-themes'

				" Enable git commands direct from vim (I use to show the
				" branch in vim-airline)
				Plug 'tpope/vim-fugitive'

				"Plugin to show + and - git signs in the text file
				Plug 'airblade/vim-gitgutter'

				" Enable line in the indent
				Plug 'Yggdroot/indentLine'

				" Enable vim arround keybinds like ca'"
				Plug 'tpope/vim-surround'

				"vim in the brownser
				Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }

				" telescope requirements (fuzzy finder in vim)
				Plug 'nvim-treesitter/nvim-treesitter'
				Plug 'nvim-lua/popup.nvim'
				Plug 'nvim-lua/plenary.nvim'
				Plug 'nvim-telescope/telescope.nvim'
				Plug 'nvim-telescope/telescope-fzy-native.nvim'
				Plug 'nvim-telescope/telescope-file-browser.nvim'

				"LSP for having language servers
				Plug 'neovim/nvim-lspconfig'
				"To enable auto completion
				Plug 'hrsh7th/nvim-compe'

				"Tree sitter. Do not need the nvim-treesitter because it was already installed in the
				"telescope requirements
				Plug 'nvim-treesitter/playground'

				"Indentation script for python
				Plug 'vim-scripts/indentpython.vim'

				"Comment in a vim like way
			    Plug 'tpope/vim-commentary'

				"csv viewer
				Plug 'chrisbra/csv.vim'

				"terraform plugins
				Plug 'hashivim/vim-terraform'

				"Database plugins
				Plug 'tpope/vim-dadbod'
				Plug 'kristijanhusak/vim-dadbod-ui'
				Plug 'kristijanhusak/vim-dadbod-completion'

				"Plugin that i use with ipython
				Plug 'jpalardy/vim-slime'

				"base 16 colorschemes
				Plug 'RRethy/nvim-base16'

				"Harpoon to move between files rapidly
				" Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
				Plug 'ThePrimeagen/harpoon'

				" Change to work directory
				Plug 'airblade/vim-rooter'

				"Buffer line
				Plug 'kyazdani42/nvim-web-devicons'
				set termguicolors

				"Plugin to measure startup time in vim
				" Plug 'dstein64/vim-startuptime'

				" LSP Support
				Plug 'neovim/nvim-lspconfig'             " Required

				" Autocompletion Engine
				Plug 'hrsh7th/nvim-cmp'         " Required
				Plug 'hrsh7th/cmp-nvim-lsp'     " Required

				"  Snippets
				Plug 'L3MON4D3/LuaSnip'             " Required

				Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v1.x'}

				"github Copilot-like
				Plug 'Exafunction/codeium.vim'
		call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INIT.LUA
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

		source ~/.config/nvim/transition.lua
