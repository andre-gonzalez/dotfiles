-- Codeium
vim.g.codeium_disable_bindings = 1
vim.keymap.set('i', '<C-F>', '<Cmd>call codeium#Accept()<CR>')
vim.keymap.set('i', '<C-;>', '<Cmd>call codeium#CycleCompletions(1)<CR>')
vim.keymap.set('i', '<C-\\>', '<Cmd>call codeium#CycleCompletions(-1)<CR>')
