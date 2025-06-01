------------------------------------------------------------------------------
----------------------------- GENERAL ----------------------------------------
------------------------------------------------------------------------------

-- set tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- set fold to manual
vim.opt.foldmethod = "manual"

-- configure buffer for SQL
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql" },
	command = [[setlocal tabstop=2 shiftwidth=2]],
})

-- Automatically deletes all trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	command = ":%s/\\s\\+$//e",
})

-- Enable line numbers
vim.wo.number = true

vim.opt.wildmode = "list:longest"

-- Ignore case in search
vim.opt.ignorecase = true

-- If you type an uppercase character in the search it will change the search to a case sensitive one
vim.opt.smartcase = true

-- allows you to paste in vim with the mouse
vim.opt.mouse = "a"

-- save undo trees in files
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"

-- number of undo saved
vim.opt.undolevels = 10000

--Search down into subfolders
--Provides tab-completion for all file-related tasks
vim.opt.path:append({ "**" })

-- Enable copying to clipboard
vim.opt.clipboard = "unnamedplus"

--set completeopt+=noselect
vim.opt.completeopt = { "menu", "menuone", "noselect" }

--Python conventoin keep line under 79 characters
vim.opt.colorcolumn = "79"

--highlight what i yank
vim.cmd([[
		augroup highlight_yank
			autocmd!
			au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
		augroup END
]])

local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = yankGrp,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- autoupdate files edited in another text editor
vim.opt.autoread = true

-- Only show command line (the line below status bar) when it is being
-- used. It gives you extra space
vim.opt.cmdheight = 0

--Disable spellchecker
vim.opt.spell = false

--Set so obsidian plugin can work properly
vim.opt_local.conceallevel = 2


-- Set filetype in ansible directory structure to yaml.ansible so LSP can load
vim.filetype.add({
	pattern = {
		['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
		['.*/roles/.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
		['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',
	},
})


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
]])
