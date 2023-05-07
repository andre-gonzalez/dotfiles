require'lspconfig'.ansiblels.setup{}
cmd = { "ansible-language-server", "--stdio" }
filetype = { "yaml.ansible" }
settings = {
  ansible = {
    ansible = {
      path = "ansible"
    },
    ansibleLint = {
      enabled = true,
      path = "ansible-lint"
    },
    executionEnvironment = {
      enabled = false
    },
    python = {
      interpreterPath = "python"
    }
  }
}
-- To ansible LSP work
vim.keymap.set('n', '<leader>af', ':set ft=yaml.ansible<CR>')
