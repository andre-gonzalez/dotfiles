------------------------------------------------------------------------------
----------------------------- GENERAL ----------------------------------------
------------------------------------------------------------------------------

-- set tab width to 4 spaces
vim.opt.tabstop = 4

-- set fold to manual
vim.opt.foldmethod = 'manual'

-- configure buffer for SQL
vim.api.nvim_create_autocmd(
		"FileType",
		{
			pattern = { "sql" },
			command = [[setlocal tabstop=2 shiftwidth=2]]
		}
)

-- Automatically deletes all trailing whitespace on save
vim.api.nvim_create_autocmd (
		"BufWritePre",
		{
			pattern = { "*" },
			command = ":%s/\\s\\+$//e"
		}
)

-- Enable line numbers
vim.wo.number = true

vim.opt.wildmode =  'list:longest'

-- Ignore case in search
vim.opt.ignorecase = true

-- If you type an uppercase character in the search it will change the search to a case sensitive one
vim.opt.smartcase = true

-- allows you to paste in vim with the mouse
vim.opt.mouse = 'a'

-- save undo trees in files
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"

-- number of undo saved
vim.opt.undolevels = 10000

--Search down into subfolders
--Provides tab-completion for all file-related tasks
vim.opt.path:append { '**' }

-- Enable copying to clipboard
vim.opt.clipboard = 'unnamedplus'

--set completeopt+=noselect
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }


--Python conventoin keep line under 79 characters
vim.opt.colorcolumn = '79'


--highlight what i yank
vim.cmd [[
		augroup highlight_yank
			autocmd!
			au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
		augroup END
]]

local yankGrp = vim.api.nvim_create_augroup(
		'YankHighlight',
		{ clear = true }
)

vim.api.nvim_create_autocmd(
		'TextYankPost',
		{
			group = yankGrp,
			pattern = '*',
			callback = function()
				vim.highlight.on_yank()
			end,
		}
)

-- autoupdate files edited in another text editor
vim.opt.autoread = true

-- Only show command line (the line below status bar) when it is being
-- used. It gives you extra space
vim.opt.cmdheight = 0

--Disable spellchecker
vim.opt.spell = false


------------------------------------------------------------------------------
----------------------------- PLUGINS ----------------------------------------
------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  "tpope/vim-surround",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  "tpope/vim-fugitive",
  "airblade/vim-gitgutter",
  "Yggdroot/indentLine",
  "tpope/vim-surround",
  "nvim-treesitter/nvim-treesitter",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-fzy-native.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-compe",
  "nvim-treesitter/playground",
  "vim-scripts/indentpython.vim",
  "tpope/vim-commentary",
  "chrisbra/csv.vim",
  "hashivim/vim-terraform",
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  "kristijanhusak/vim-dadbod-completion",
  "jpalardy/vim-slime",
  "RRethy/nvim-base16",
  "ThePrimeagen/harpoon",
  "airblade/vim-rooter",
  "kyazdani42/nvim-web-devicons",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "Exafunction/codeium.vim",
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  },
  'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
        require("lazy").load({ plugins = "firenvim", wait = true })
        vim.fn["firenvim#install"](0)
    end,
	'akinsho/bufferline.nvim'
})

require("plugins.telescope")
require("lsp.lsp-zero")
require("lsp.lsp-config")
require("lsp.ansible-lsp")
require("lsp.bash-lsp")
require("lsp.grammarly-lsp")
require("lsp.json-lsp")
require("lsp.terraform-lsp")
require("lsp.python-lsp")
require("lsp.sql-lsp")
require("plugins.buffer-line")
require("plugins.compe-config")
------------------------------------------------------------------------------
----------------------------- REMAPS -----------------------------------------
------------------------------------------------------------------------------

-- Clear search highlights with a keybind
-- vim.keymap.set('n', '<C-L>', ':nohlsearch<CR>')

-- Remaped the leader key
--vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- DBUI
vim.keymap.set('n', '<leader>bf', ':DBUIFindBuffer<CR>')

-- use s as an alias to replace all
vim.keymap.set('n', '<leader>S', ':%s//g<Left><Left>')

-- Enable spell checking
vim.keymap.set('n', '<leader>roe', ':setlocal spell! spelllang=en_us<CR>')
vim.keymap.set('n', '<leader>rop', ':setlocal spell! spelllang=pt_br<CR>')

-- Fill with the date and hour
vim.keymap.set('n', '<F3>', 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>')
vim.keymap.set('i', '<F3>', '<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>')

-- harpoon remaps
vim.keymap.set('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>')
vim.keymap.set('n', '<leader>e', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.keymap.set('n', '<leader>h', ':lua require("harpoon.ui").nav_file(1)<CR>')
vim.keymap.set('n', '<leader>t', ':lua require("harpoon.ui").nav_file(2)<CR>')
vim.keymap.set('n', '<leader>n', ':lua require("harpoon.ui").nav_file(3)<CR>')
vim.keymap.set('n', '<leader>s', ':lua require("harpoon.ui").nav_file(4)<CR>')

-- insert lines to debug in python
-- vim.keymap.set('n', '<leader>bb', ':lua require("dap").toggle_breakpoint()<CR>')
vim.keymap.set('n', '<leader>bb', 'ifrom ipdb import set_trace as st<CR>st()<Esc>')

--  Remap to paste delete and paste without change the register
vim.keymap.set('x', '<leader>p', '"_dP')

-- Delete without saving to register
vim.keymap.set('x', '<leader>d', '"_d')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- Insert line using o but keeping you in normal mode
vim.keymap.set('n', '<leader>o', 'o<Esc>')
vim.keymap.set('n', '<leader>O', 'O<Esc>')

-- Move with the screen centralized
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Find last search match with screen centralized
vim.keymap.set('n', 'n', 'nzz')

--Insert image in markdown note
vim.keymap.set('n', '<leader>i', ":r!cd _attachment && ls '.png'<left><left><left><left><left>")

-- Format images in markdown format
vim.keymap.set('n', '<leader>mi', ':%s/\\(.*\\)\\.png$/![\\1](\\1.png)<CR>')

-- Set filetype
vim.keymap.set('n', '<leader>qs', ':set filetype=sql<CR>')
vim.keymap.set('n', '<leader>qp', ':set filetype=python<CR>')

-- Move what is highlighted
vim.keymap.set('v', 'J', ":m \\'>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m \\'<-2<CR>gv=gv")

-- When using J keep cursor still
vim.keymap.set('n', 'J', 'mzJ`z')

-- When searching keep the cursos in the middle of the screen
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Getting rid of Ex mode
vim.keymap.set('n', 'Q', '<nop>')

-- Remap to substitute a word in the file
vim.keymap.set('n', '<leader>ws', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- Make a file executable
vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>')

-- Codeium
vim.keymap.set('i', '<C-f>', 'codeium#Accept()')
vim.keymap.set('i', '<C-;>', '<Cmd>call codeium#CycleCompletions(1)<CR>')
vim.keymap.set('i', '<C-\\>', '<Cmd>call codeium#CycleCompletions(-1)<CR>')

--colorscheme base16-onedark
vim.cmd('colorscheme base16-onedark')

-- Set line numbers as white
vim.cmd('highlight LineNr guifg=#ABB2BF')

-- To ansible LSP work
vim.keymap.set('n', '<leader>af', ':set ft=yaml.ansible<CR>')

-- LSP config (the mappings used in the default file don't quite work right)
vim.keymap.set('n', 'gd',  '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD',  '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gr',  '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<C-k>',  '<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<C-n>',  '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<C-p>',  '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

------------------------------------------------------------------------------
----------------------------- ABREVIATIONS -----------------------------------
------------------------------------------------------------------------------

vim.cmd('ab SF SELECT * FROM;<up><right><right><right>')
vim.cmd('ab SLIMIT SELECT *<cr>FROM<cr>LIMIT 200<cr>;<up><up><right><right><right>')
vim.cmd('ab SDIST SELECT DISTINCT<cr>FROM<cr>;<up><right><right><right>')
vim.cmd('ab SCOLUMNS SELECT "column_name"<cr>FROM information_schema."columns"<cr>WHERE "table_name" = \'\'<cr>;<up><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>')
vim.cmd('ab skeletonmd #<cr><cr>## Participantes:<cr>- [[]]<cr><cr>---<cr># Notas:<cr>- <cr>---<cr># To-do:<cr>- [ ]')
vim.cmd('ab dcom # COMMAND ----------')

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
