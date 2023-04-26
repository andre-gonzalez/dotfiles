"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basics
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

		"alternate between relative line numbers and absolute based in wich mode you are
		" set number
		augroup numbertoggle
		  autocmd!
		  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
		  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
		augroup END

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

		source ~/.config/nvim/transition.lua

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

		"Insert image in markdown note
		nnoremap <leader>i :r!cd _attachment && ls '.png'<left><left><left><left><left>
		"Format images in markdown format
		nnoremap <leader>mi :%s/\(.*\)\.png$/![\1](\1.png)<CR>

		"Set filetype
		nnoremap <leader>qs :set filetype=sql<CR>
		nnoremap <leader>qp :set filetype=python<CR>

		"Move what is highlighted
		vnoremap J :m '>+1<CR>gv=gv
		vnoremap K :m '<-2<CR>gv=gv

		"When using J keep cursor still
		nnoremap J mzJ`z

		"When searching keep the cursos in the middle of the screen
		nnoremap n nzzzv
		nnoremap N Nzzzv

		"Getting rid of Ex mode
		nnoremap Q <nop>

		"Remap to substitute a word in the file
		nnoremap <leader>ws :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

		"Make a file executable
		nnoremap <leader>x <cmd>!chmod +x %<CR>

		"Codeium
		imap <script><silent><nowait><expr> <C-f> codeium#Accept()
		imap <leader>.   <Cmd>call codeium#CycleCompletions(1)<CR>
		imap <leader>,   <Cmd>call codeium#CycleCompletions(-1)<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		" PLugin nvim-compe config file
		source ~/.config/nvim/compe-config.lua

		" Plugin lsp-config config file
		source ~/.config/nvim/lsp-config.vim

		"Bash completion
		source ~/.config/nvim/bash-lsp.lua

		"Python completion
		source ~/.config/nvim/python-lsp.lua

		"SQL completion
		source ~/.config/nvim/sql-lsp.lua

		"Ansible completion
		source ~/.config/nvim/ansible-lsp.lua

		map <leader>af :set ft=yaml.ansible<CR>

		"Terraform completion
		source ~/.config/nvim/terraform-lsp.lua

		"Grammarly completion
		source ~/.config/nvim/grammarly-lsp.lua

		"Json completion
		source ~/.config/nvim/json-lsp.lua

		"Telecope file_browser configs
		source ~/.config/nvim/telescope.lua

		"Buffer line
		source ~/.config/nvim/buffer-line.lua

		"lsp zero
		source ~/.config/nvim/lsp-zero.lua

		"SQL Server completion
		let g:LanguageClient_serverCommands = {
			\ 'sql': ['sql-language-server', 'up', '--method', 'stdio'],
			\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		" My coloscheme of choice
		" colorscheme gruvbox
		" colorscheme dracula
        colorscheme base16-onedark
		" Set line numbers as white
		highlight LineNr guifg=#ABB2BF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		ab SF SELECT *<cr>FROM<cr>;<up><right><right><right>
		ab SLIMIT SELECT *<cr>FROM<cr>LIMIT 200<cr>;<up><up><right><right><right>
		ab SDIST SELECT DISTINCT<cr>FROM<cr>;<up><right><right><right>
		ab SCOLUMNS SELECT "column_name"<cr>FROM information_schema."columns"<cr>WHERE "table_name" = ''<cr>;<up><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>
		ab skeletonmd #<cr><cr>## Participantes:<cr>- [[]]<cr><cr>---<cr># Notas:<cr>- <cr>---<cr># To-do:<cr>- [ ]
		ab dcom # COMMAND ----------
