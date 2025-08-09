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

-- Disable command line window open command
vim.keymap.set("n", "q:", "<Nop>", { noremap = true })

-- ─────────────────────────────────────────────────────────
-- Helper: grab exactly what you visually selected, as a list of lines
-- ─────────────────────────────────────────────────────────
-- Returns a list of strings: exactly the lines (and columns) you highlighted in Visual mode.
-- You must be in Visual mode (v/V/) when calling this.
local function _get_visual_selection_lines()
  local s_pos = vim.fn.getpos("'<")
  local e_pos = vim.fn.getpos("'>")
  local start_row, start_col = s_pos[2], s_pos[3]
  local end_row,   end_col   = e_pos[2],   e_pos[3]

  -- Grab all lines from start_row through end_row
  local lines = vim.fn.getline(start_row, end_row)
  if #lines == 0 then
    return {}
  end

  -- Trim off any extra columns on the first and last lines
  lines[1]       = string.sub(lines[1],       start_col)
  lines[#lines]  = string.sub(lines[#lines],   1, end_col)

  return lines
end

local function hide_everything_but_result()
  vim.defer_fn(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf   = vim.api.nvim_win_get_buf(win)
      local ftype = vim.bo[buf].filetype
      if ftype ~= "dbee-result" then
        -- close all windows that aren’t the result pane
        vim.api.nvim_win_close(win, true)
      end
    end
  end, 100)  -- give Dbee ~100ms to finish drawing
end

-- ─────────────────────────────────────────────────────────
-- Main function: run whatever was visually selected, via dbee.execute()
-- ─────────────────────────────────────────────────────────
function _G.run_sql_visual_flattened()
  local lines = _get_visual_selection_lines()
  if #lines == 0 then
    vim.notify("No SQL selected in Visual mode.", vim.log.levels.WARN)
    return
  end

  -- Join all lines with a single space so dbee.parse() sees one continuous statement.
  local sql = table.concat(lines, " ")

  -- Now send that single-line SQL to nvim-dbee.
  -- (Make sure you have already done :lua require("dbee").open() at least once,
  --  so that there’s an active connection. Otherwise execute() will error.)
  require("dbee").execute(sql)
	hide_everything_but_result()
end

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
