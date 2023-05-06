require("base")
require("lazy-plugins")
require("remaps")
require("abbreviations")

------------------------------------------------------------------------------
----------------------------- OLD VIM COMMANDS -------------------------------
------------------------------------------------------------------------------
vim.cmd([[
"alternate between relative line numbers and absolute based in wich mode you are
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" auto-format
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.sql lua vim.lsp.buf.formatting_sync(nil, 100)

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
]])
