return {
	"lewis6991/gitsigns.nvim",
	--
	-- Use an event like 'BufRead' and check if the file is in a git repo
	event = "BufReadPre",
	cond = function()
		-- Check if the current file is in a Git repository
		return vim.fn.isdirectory(".git") == 1
	end,

	config = function()
		require("gitsigns").setup()
	end,
}
