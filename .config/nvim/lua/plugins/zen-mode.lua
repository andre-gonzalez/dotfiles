return {

  "folke/zen-mode.nvim",

	config = function()
		vim.keymap.set("n", "<leader>zz", function()

				require("zen-mode").setup {
						window = {
							width = 200,
							options = { }
						},
						plugins = {
							tmux = { enabled = true }, -- disables the tmux statusline
							},
				}

				require("zen-mode").toggle()

		end)
	end

}
