return {

	{

		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		config = function()
			require("telescope").setup({
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
			})
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>tf", function()
				builtin.find_files({
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"-g",
						"!.git",
					},
				})
			end)

			vim.keymap.set("n", "<leader>tg", function()
				builtin.live_grep({
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"-g",
						"!.git",
					},
				})
			end)

			vim.keymap.set("n", "<leader>tb", builtin.buffers, {})

			vim.keymap.set("n", "<leader>tc", ":Telescope file_browser<CR>", {
				noremap = true,
			})
		end,
	},

	{
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
	},

	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}
