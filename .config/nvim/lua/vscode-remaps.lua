-- call vscode commands from neovim

-- general keymaps
vim.keymap.set({"n", "v"}, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
vim.keymap.set({"n", "v"}, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
vim.keymap.set({"n", "v"}, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
vim.keymap.set({"n", "v"}, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
vim.keymap.set({"n", "v"}, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
vim.keymap.set({"n", "v"}, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
vim.keymap.set({"n", "v"}, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
vim.keymap.set({"n", "v"}, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
vim.keymap.set({"n", "v"}, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
vim.keymap.set({"n", "v"}, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

-- harpoon keymaps
vim.keymap.set({"n", "v"}, "<leader>ha", "<cmd>lua require('cursor').action('cursor-harpoon.addEditor')<CR>")
vim.keymap.set({"n", "v"}, "<leader>ho", "<cmd>lua require('cursor').action('cursor-harpoon.editorQuickPick')<CR>")
vim.keymap.set({"n", "v"}, "<leader>he", "<cmd>lua require('cursor').action('cursor-harpoon.editEditors')<CR>")
vim.keymap.set({"n", "v"}, "<leader>h1", "<cmd>lua require('cursor').action('cursor-harpoon.gotoEditor1')<CR>")
vim.keymap.set({"n", "v"}, "<leader>h2", "<cmd>lua require('cursor').action('cursor-harpoon.gotoEditor2')<CR>")
vim.keymap.set({"n", "v"}, "<leader>h3", "<cmd>lua require('cursor').action('cursor-harpoon.gotoEditor3')<CR>")
vim.keymap.set({"n", "v"}, "<leader>h4", "<cmd>lua require('cursor').action('cursor-harpoon.gotoEditor4')<CR>")
vim.keymap.set({"n", "v"}, "<leader>h5", "<cmd>lua require('cursor').action('cursor-harpoon.gotoEditor5')<CR>")
vim.keymap.set({"n", "v"}, "<leader>h6", "<cmd>lua require('cursor').action('cursor-harpoon.gotoEditor6')<CR>")
vim.keymap.set({"n", "v"}, "<leader>h7", "<cmd>lua require('cursor').action('cursor-harpoon.gotoEditor7')<CR>")
vim.keymap.set({"n", "v"}, "<leader>h8", "<cmd>lua require('cursor').action('cursor-harpoon.gotoEditor8')<CR>")
vim.keymap.set({"n", "v"}, "<leader>h9", "<cmd>lua require('cursor').action('cursor-harpoon.gotoEditor9')<CR>")
