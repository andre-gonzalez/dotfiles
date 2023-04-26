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
----------------------------- REMAPS -----------------------------------------
------------------------------------------------------------------------------

-- Clear search highlights with a keybind
-- vim.keymap.set('n', '<C-L>', ':nohlsearch<CR>')

-- Remaped the leader key
vim.g.mapleader = " "

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
