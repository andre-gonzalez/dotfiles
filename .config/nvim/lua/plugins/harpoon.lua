return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim"
	},
	config = function()
		local harpoon = require("harpoon")
		local list = harpoon:list()

		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		vim.keymap.set("n", "<C-h>", function() list:select(1) end, { desc = "Harpoon file 1" })
		vim.keymap.set("n", "<C-t>", function() list:select(2) end, { desc = "Harpoon file 2" })
		vim.keymap.set("n", "<C-n>", function() list:select(3) end, { desc = "Harpoon file 3" })
		vim.keymap.set("n", "<C-s>", function() list:select(4) end, { desc = "Harpoon file 4" })

		harpoon:setup({})

		-- -- basic telescope configuration
		-- local conf = require("telescope.config").values
		-- local function toggle_telescope(harpoon_files)
		-- 	local file_paths = {}
		-- 	for _, item in ipairs(harpoon_files.items) do
		-- 		table.insert(file_paths, item.value)
		-- 	end

		-- 	require("telescope.pickers").new({}, {
		-- 		prompt_title = "Harpoon",
		-- 		finder = require("telescope.finders").new_table({
		-- 			results = file_paths,
		-- 		}),
		-- 		previewer = conf.file_previewer({}),
		-- 		sorter = conf.generic_sorter({}),
		-- 	}):find()
		-- end

		-- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
		-- 	{ desc = "Open harpoon window" })
	end
}
