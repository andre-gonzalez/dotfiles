local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable underline, it's very annoying
        underline = false,
    })

-- LSP config (the mappings used in the default file don't quite work right)
vim.keymap.set('n', 'gd',  '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD',  '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gr',  '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<C-k>',  '<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<C-y>',  '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<C-p>',  '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
