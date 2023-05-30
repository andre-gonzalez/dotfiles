require("telescope").setup {
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', function()
	builtin.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
end)
vim.keymap.set('n', '<leader>g', function()
	builtin.live_grep({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
end)
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
vim.keymap.set('n', '<leader>c',   ":Telescope file_browser<CR>",  { noremap = true })
