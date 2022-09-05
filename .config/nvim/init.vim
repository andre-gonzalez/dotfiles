"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TO-DOs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	- Learn to use fugitive.vim
"	- Learn to personalize vim-airline


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basics
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		" enable syntax highlight
		syntax on

		" Set tab width to 4 columns.
		set tabstop=4

		" Enable auto completion menu after pressing TAB in command mode
		set wildmenu

		" Make wildmenu behave like similar to Bash completion.
		set wildmode=list:longest

		" Automatically deletes all trailing whitespace on save
		autocmd BufWritePre * %s/\s\+$//e

		"alternate between relative line numbers and absolute based in wich mode you are
		:set number
		:augroup numbertoggle
		:  autocmd!
		:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
		:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
		:augroup END

		" enable incremental search
		set incsearch

		" Leave 8 lines at the top when scrolling with Ctrl + D
		set scrolloff=8

		" Ignore case in search
		set ignorecase
		" If you type an uppercase character in the search it will change the search to a case
		" sensitive one
		set smartcase

		"allows you to paste in vim with the mouse
		set mouse=a

		" save undo trees in files
		set undofile
		set undodir=~/.vim/undo

		" number of undo saved
		set undolevels=10000

		"Search down into subfolders
		"Provides tab-completion for all file-related tasks
		set path+=**

		" consider only 100 columns until break line
		"setl tw=100

		"Enable copying to clipboard there is two lines becaus it is one for each linux clipboard
		set clipboard+=unnamedplus
		" set clipboard=unnamed

		" completion
		set completeopt+=noselect

		" use w!! to save when you open a file in read only mode. You need to type faster so it can
		" work
		cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

		" Use <C-L> to clear the highlighting of :set hlsearch.
		if maparg('<C-L>', 'n') ==# ''
		  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
		endif

		" Syntax highlight in markdown files
		let g:markdown_fenced_languages = ['html', 'python', 'SQL', 'vim', 'HCL', 'CSS']

		"Python conventoin keep line under 79 characters
		set colorcolumn=79


		"highlight what i yank
		augroup highlight_yank
			autocmd!
			au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
		augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		call plug#begin()

				" Better markdown highlight and some keybinds to make easier to edit markdown files
				Plug 'gabrielelana/vim-markdown'

				"Plugin to preview markdown files in the brownser
				Plug 'iamcco/markdown-preview.nvim'

				"Set a infomative line in the bottom of the editor
				Plug 'vim-airline/vim-airline'

				" Enable git commands direct from vim
				Plug 'tpope/vim-fugitive'

				"Plugin to show + and - git signs in the text file
				Plug 'airblade/vim-gitgutter'

				" Enable line in the indent
				Plug 'Yggdroot/indentLine'

				" Enable vim arround keybinds like ca'"
				Plug 'tpope/vim-surround'

				" File tree explorer
				Plug 'preservim/nerdtree'

				" colorscheme
				Plug 'morhetz/gruvbox'

				" dracula colorscheme
				" Plug 'Mofiqul/dracula.nvim'

				Plug 'rentalcustard/exuberant-ctags'

				"vim in the brownser
				Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }

				" telescope requirements (fuzzy finder in vim)
				Plug 'nvim-treesitter/nvim-treesitter'
				Plug 'nvim-lua/popup.nvim'
				Plug 'nvim-lua/plenary.nvim'
				Plug 'nvim-telescope/telescope.nvim'
				Plug 'nvim-telescope/telescope-fzy-native.nvim'

				"LSP for having language servers
				Plug 'neovim/nvim-lspconfig'
				"To enable auto completion
				Plug 'hrsh7th/nvim-compe'

				"Tree sitter. Do not need the nvim-treesitter because it was already installed in the
				"telescope requirements
				Plug 'nvim-treesitter/playground'

				" enable jupyter notebook inside vim
				Plug 'untitled-ai/jupyter_ascending.vim'

				"Indentation script for python
				Plug 'vim-scripts/indentpython.vim'

				"Code folding for python
				Plug 'tmhedberg/SimpylFold'

				"Comment in a vim like way
			    Plug 'tpope/vim-commentary'

				"fish syntax highlight
				Plug 'dag/vim-fish'

				"csv viewer
				Plug 'chrisbra/csv.vim'

				"terraform plugins
				Plug 'hashivim/vim-terraform'

				"Datapase plugins
				Plug 'tpope/vim-dadbod'
				Plug 'kristijanhusak/vim-dadbod-ui'
				Plug 'kristijanhusak/vim-dadbod-completion'

				"Vim wiki obisidian alternative
				Plug 'vimwiki/vimwiki'

				"Plugin that i use with ipython
				Plug 'jpalardy/vim-slime'

				"instant markdown visualizer
				Plug 'instant-markdown/vim-instant-markdown'
				"base 16 colorschemes
				Plug 'RRethy/nvim-base16'

				"Harpoon to move between files rapidly
				Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
				Plug 'ThePrimeagen/harpoon'
		call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

		" Set firenvim extension to ignore whats app
		" let fc['https?://web.whatsapp.com/'] = {'takeover': 'never', 'priority': 1 }
		" Set filetype of Firenvim in gmail to markdown
		au BufEnter mail.google.com_*.txt set filetype=markdown
		au BufEnter app.datacamp.com_*.txt set filetype=python
		au BufEnter hackerrank.com_*.txt set filetype=python

		let g:SimpylFold_docstring_preview = 1
		let g:SimpylFold_fold_docstring = 0
		let b:SimpylFold_fold_docstring = 0

		"jupyter-vim
		if has('nvim')
			let g:python3_host_prog = '/path/to/python/bin/python3'
		else
			set pyxversion=3
		endif

		"vim-slime
		let g:slime_target = "tmux"
		let g:slime_paste_file = "$HOME/.cache/slime_paste"

		"Instant markdown
		filetype plugin on
		"Uncomment to override defaults:
		" let g:instant_markdown_slow = 1
		"let g:instant_markdown_autostart = 0
		"let g:instant_markdown_open_to_the_world = 1
		"let g:instant_markdown_allow_unsafe_content = 1
		"let g:instant_markdown_allow_external_content = 0
		"let g:instant_markdown_mathjax = 1
		"let g:instant_markdown_mermaid = 1
		"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
		"let g:instant_markdown_autoscroll = 0
		"let g:instant_markdown_port = 8888
		" let g:instant_markdown_python = 1
		let g:instant_markdown_browser = "qutebrowser --target auto"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		"Remaped the leader key
		let mapleader = " "

		"use s as an alias to replace all
		noremap <leader>s :%s//g<Left><Left>

		"move between split windows using ctrl + h,j,k,l
		map <C-h> <C-w>h
		map <C-j> <C-w>j
		map <C-k> <C-w>k
		map <C-l> <C-w>l

		" Enable spell checking
		map <leader>oe :setlocal spell! spelllang=en_us<CR>
		map <leader>op :setlocal spell! spelllang=pt_br<CR>

		"fill with the date and hour
		nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
		imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

		" remap to preview markdown
		nmap <Leader>p <Plug>MarkdownPreview

		" remap to run telescope with \ + f
		nnoremap <Leader>f :lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>

		" harpoon remaps
		nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
		nnoremap <leader>e :lua require("harpoon.ui").toggle_quick_menu()<CR>
		nnoremap <leader>h :lua require("harpoon.ui").nav_file(1)<CR>
		nnoremap <leader>t :lua require("harpoon.ui").nav_file(2)<CR>
		nnoremap <leader>n :lua require("harpoon.ui").nav_file(3)<CR>
		nnoremap <leader>s :lua require("harpoon.ui").nav_file(4)<CR>

		" remap to run nerdtree with \ + n
		nnoremap <leader>n :NERDTreeFocus<CR>

		" insert lines to debug in python
		nnoremap <leader>db ifrom ipdb import set_trace as st<CR>st()<Esc>

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

		"SQL Server completion
		let g:LanguageClient_serverCommands = {
			\ 'sql': ['sql-language-server', 'up', '--method', 'stdio'],
			\ }
		"Database operations
		nnoremap <silent> <leader>du :DBUIToggle<CR>
		nnoremap <silent> <leader>df :DBUIFindBuffer<CR>
		nnoremap <silent> <leader>dr :DBUIRenameBuffer<CR>
		nnoremap <silent> <leader>dl :DBUILastQueryInfo<CR>
		let g:db_ui_save_location = '~/eureciclo/salesops-dw/main-salesops-dw/queries'
		let g:db_ui_tmp_query_location = '~/eureciclo/salesops-dw/main-salesops-dw/tmp'
		" autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		" Set background to dark
		set background=dark

		" My coloscheme of choice
		" colorscheme gruvbox
		" colorscheme dracula
		colorscheme base16-onedark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		ab SF SELECT * FROM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim wiki configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Random
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
