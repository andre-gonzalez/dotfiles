return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
	opts = {
		heading = { width = "block", left_pad = 1, right_pad = 2 },
		code = { width = "block", left_pad = 2, right_pad = 2 },
		checkbox = { enabled = true },
		pipe_table = { preset = "round" },
	},
	keys = {
		{ "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle markdown render" },
	},
}
