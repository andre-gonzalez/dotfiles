return {
	'nvim-treesitter/nvim-treesitter',
	branch = "main",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		require("nvim-treesitter").install({
			"bash", "c", "cpp", "diff", "git_config", "gitcommit", "gitignore", "json",
			"lua", "markdown", "markdown_inline", "nix", "python", "query", "regex",
			"toml", "vim", "vimdoc", "yaml"
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_features", { clear = true }),
			pattern = "*",
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- Re-trigger FileType for the buffer that caused this plugin to load
		vim.cmd("doautocmd FileType")
	end
}
