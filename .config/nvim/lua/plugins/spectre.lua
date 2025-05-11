return {
	"nvim-pack/nvim-spectre",
	keys = {
		{
			"<leader>S",
			'<cmd>lua require("spectre").toggle()<CR>',
			desc = "Spectre: Toggle UI",
		},
		{
			"<leader>sw",
			'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
			mode = "n",
			desc = "Spectre: Search current word",
		},
		{
			"<leader>sw",
			'<esc><cmd>lua require("spectre").open_visual()<CR>',
			mode = "v",
			desc = "Spectre: Search selection",
		},
		{
			"<leader>sp",
			'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
			desc = "Spectre: Search current file",
		},
	},
}
