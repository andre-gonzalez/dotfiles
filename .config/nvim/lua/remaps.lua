------------------------------------------------------------------------------
----------------------------- REMAPS -----------------------------------------
------------------------------------------------------------------------------

-- Clear search highlights with a keybind
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR>")

-- Remaped the leader key
vim.g.mapleader = " "
-- vim.g.maplocalleader = ' '

-- use s as an alias to replace all
vim.keymap.set("v", "<leader>s", ":s//g<Left><Left>")
vim.keymap.set("n", "<leader>S", ":%s//g<Left><Left>")

-- Remap to substitute a word in the file
vim.keymap.set("n", "<leader>ws", ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>")

-- Enable spell checking
vim.keymap.set("n", "<leader>roe", ":setlocal spell! spelllang=en_us<CR>")
vim.keymap.set("n", "<leader>rop", ":setlocal spell! spelllang=pt_br<CR>")

-- Fill with the date and hour
vim.keymap.set("n", "<F3>", 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>')
vim.keymap.set("i", "<F3>", '<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>')

-- insert lines to debug in python
-- vim.keymap.set('n', '<leader>bb', ':lua require("dap").toggle_breakpoint()<CR>')
vim.keymap.set("n", "<leader>bb", "ifrom ipdb import set_trace as st<CR>st()<Esc>")

--  Remap to paste delete and paste without change the register
vim.keymap.set("x", "<leader>p", '"_dP')

-- Delete without saving to register
vim.keymap.set("x", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Insert line using o but keeping you in normal mode
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- Move with the screen centralized
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Find last search match with screen centralized
vim.keymap.set("n", "n", "nzz")

--Insert image in markdown note
vim.keymap.set("n", "<leader>i", ":r!cd _attachment && ls '.png'<left><left><left><left><left>")

-- Set filetype
vim.keymap.set("n", "<leader>qs", ":set filetype=sql<CR>")
vim.keymap.set("n", "<leader>qp", ":set filetype=python<CR>")
vim.keymap.set("n", "<leader>qm", ":set filetype=markdown<CR>")

-- format sql queries
vim.keymap.set("n", "<leader>qf", ':%!sqlformat -r --comma_first True -k "upper" - <CR>')

-- Move what is highlighted
vim.keymap.set("v", "J", ":m \'>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m \'<-2<CR>gv=gv")

-- When using J keep cursor still
vim.keymap.set("n", "J", "mzJ`z")

-- When searching keep the cursos in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Getting rid of Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Make a file executable
vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>")

-- Keybinds to temporary see a split in fullscreen
vim.keymap.set("n", "<leader>ts", ":tab split<CR>")
vim.keymap.set("n", "<leader>tc", ":tabc<CR>")
vim.keymap.set("n", "<leader>tn", ":enew | startinsert<CR>")

-- Hide tab line
vim.opt.showtabline = 0

-- Move beteween markdown headers
vim.keymap.set("n", "gk", function()
  -- `?` - Start a search backwards from the current cursor position.
  -- `^` - Match the beginning of a line.
  -- `##` - Match 2 ## symbols
  -- `\\+` - Match one or more occurrences of prev element (#)
  -- `\\s` - Match exactly one whitespace character following the hashes
  -- `.*` - Match any characters (except newline) following the space
  -- `$` - Match extends to end of line
  vim.cmd("silent! ?^##\\+\\s.*$")
  -- Clear the search highlight
  vim.cmd("nohlsearch")
end, { desc = "Go to previous markdown header" })

-- Search DOWN for a markdown header
-- Make sure to follow proper markdown convention, and you have a single H1
-- heading at the very top of the file
-- This will only search for H2 headings and above
vim.keymap.set("n", "gj", function()
  -- `/` - Start a search forwards from the current cursor position.
  -- `^` - Match the beginning of a line.
  -- `##` - Match 2 ## symbols
  -- `\\+` - Match one or more occurrences of prev element (#)
  -- `\\s` - Match exactly one whitespace character following the hashes
  -- `.*` - Match any characters (except newline) following the space
  -- `$` - Match extends to end of line
  vim.cmd("silent! /^##\\+\\s.*$")
  -- Clear the search highlight
  vim.cmd("nohlsearch")
end, { desc = "Go to next markdown header" })

vim.keymap.set(
  "v",
  "<leader>bq",
  "<cmd>lua run_sql_visual_flattened()<CR>",
  { desc = "Run the visually‐selected SQL via nvim‐dbee" }
)

-- ─────────────────────────────────────────────────────────
-- Transparent background toggle
-- ─────────────────────────────────────────────────────────

local original_bg = nil
local original_colorcolumn_bg = nil
local transparency_enabled = false

function ToggleTransparency()
  if not transparency_enabled then
    -- Save current backgrounds
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    original_bg = normal_hl.bg

    local cc_hl = vim.api.nvim_get_hl(0, { name = "ColorColumn" })
    original_colorcolumn_bg = cc_hl.bg

    -- Set transparency
    vim.cmd [[
      highlight Normal guibg=NONE
      highlight NormalNC guibg=NONE
      highlight SignColumn guibg=NONE
      highlight LineNr guibg=NONE
      highlight VertSplit guibg=NONE
      highlight ColorColumn guibg=NONE
    ]]

    transparency_enabled = true
    print("Transparency enabled")
  else
    -- Restore original background if available
    if original_bg then
      local bg_color = string.format("#%06x", original_bg)
      vim.cmd("highlight Normal guibg=" .. bg_color)
      vim.cmd("highlight NormalNC guibg=" .. bg_color)
      vim.cmd("highlight SignColumn guibg=" .. bg_color)
      vim.cmd("highlight LineNr guibg=" .. bg_color)
      vim.cmd("highlight VertSplit guibg=" .. bg_color)
    else
      vim.cmd [[
        highlight Normal guibg=default
        highlight NormalNC guibg=default
        highlight SignColumn guibg=default
        highlight LineNr guibg=default
        highlight VertSplit guibg=default
      ]]
    end

    -- Restore ColorColumn background
    if original_colorcolumn_bg then
      local cc_bg_color = string.format("#%06x", original_colorcolumn_bg)
      vim.cmd("highlight ColorColumn guibg=" .. cc_bg_color)
    else
      vim.cmd [[ highlight ColorColumn guibg=default ]]
    end

    transparency_enabled = false
    print("Transparency disabled")
  end
end

-- Keymap
vim.keymap.set("n", "<leader>;", ToggleTransparency, { desc = "Toggle background transparency" })
