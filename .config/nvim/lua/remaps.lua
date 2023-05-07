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
vim.keymap.set('n', '<leader>qf', ':%!sqlformat -r --comma_first True -k "upper" - <CR>')

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
vim.g.codeium_disable_bindings = 1
vim.keymap.set('i', '<C-F>', '<Cmd>call codeium#Accept()<CR>')
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

