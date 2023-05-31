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

function TrimEndLines()
    let save_cursor = getpos(".")
    silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

autocmd BufWritePre *.py call TrimEndLines()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    "firenvim config
		au BufEnter d8c7fc-e847.cloud.databricks.com_*.txt set filetype=sql
		au BufEnter mail.google.com_*.txt set filetype=markdown

		"vim-slime
		let g:slime_target = "tmux"
		let g:slime_paste_file = expand("$HOME/.cache/slime_paste")

		"Database operations
		let g:db_ui_save_location = '~/eureciclo/salesops-dw/main-salesops-dw/queries'
		let g:db_ui_tmp_query_location = '~/eureciclo/salesops-dw/main-salesops-dw/tmp'
		let g:db_ui_winwidth = 10 " change drawer width
		let g:db_ui_execute_on_save = 0 " Disable the executing of the query on save
		let g:db_ui_force_echo_notifications = 1 "Force notifications to be show on command line
		autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni

function TrimEndLines()
    let save_cursor = getpos(".")
    silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

autocmd BufWritePre *.py call TrimEndLines()
]])
