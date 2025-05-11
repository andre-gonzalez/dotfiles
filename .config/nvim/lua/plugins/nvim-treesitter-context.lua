return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "BufReadPost",
	config = function()
		require("treesitter-context").setup({
			max_lines = 10
		})
	end
}
