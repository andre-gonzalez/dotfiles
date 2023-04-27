"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basics
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		source ~/.config/nvim/transition.lua

		"alternate between relative line numbers and absolute based in wich mode you are
		" set number
		augroup numbertoggle
		  autocmd!
		  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
		  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
		augroup END

		" auto-format
		autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
		" autocmd BufWritePre *.sql lua vim.lsp.buf.formatting_sync(nil, 100)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

		"firenvim config
		let g:firenvim_config = {
			\ 'globalSettings': {
				\ 'alt': 'all',
				\ 'takeover': 'never'
			\  },
			\ 'localSettings': {
				\ '.*': {
				\ },
			\ }
		\ }
		let fc = g:firenvim_config['localSettings']
		let fc['https?://.+'] = { 'takeover': 'never', 'priority': 1 }
		let fc['.*'] = { 'cmdline' : 'neovim' }
		au BufEnter d8c7fc-e847.cloud.databricks.com_*.txt set filetype=sql
		au BufEnter mail.google.com_*.txt set filetype=markdown
		let g:timer_started = v:false

		"vim-slime
		let g:slime_target = "tmux"
		let g:slime_paste_file = expand("$HOME/.cache/slime_paste")

		"Vim airline
		let g:airline#extensions#tabline#enabled = 0 " Enable the list of buffers
		let g:airline#extensions#tabline#formatter = 'default'  " f/p/file-name.js
		let g:airline#extensions#tabline#formatter = 'jsformatter' " path-to/f
		let g:airline#extensions#tabline#formatter = 'unique_tail' " file-name.js
		let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " f/p/file-name.js
		let g:airline#extensions#disable_rtp_load=1 "fix error messages when starting neovim

		"Database operations
		let g:db_ui_save_location = '~/eureciclo/salesops-dw/main-salesops-dw/queries'
		let g:db_ui_tmp_query_location = '~/eureciclo/salesops-dw/main-salesops-dw/tmp'
		let g:db_ui_winwidth = 10 " change drawer width
		let g:db_ui_execute_on_save = 0 " Disable the executing of the query on save
		let g:db_ui_force_echo_notifications = 1 "Force notifications to be show on command line
		autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


		" remap to run telescope with \ + f
		nnoremap <Leader>f :lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>
		nnoremap <leader>g :lua require('telescope.builtin').live_grep({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>
		nnoremap <leader>c :Telescope file_browser<CR>

		"autoformat SQL
		" autocmd FileType sql call SqlFormatter()
		" augroup end
		" function SqlFormatter()
		" 	set noai
		" 	" set mappings...
		" 	map <leader>pt  :%!sqlformat --reindent --keywords upper --identifiers lower -<CR>
		" endfunction

		"SQL Server completion
		let g:LanguageClient_serverCommands = {
			\ 'sql': ['sql-language-server', 'up', '--method', 'stdio'],
			\ }
