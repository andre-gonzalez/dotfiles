return {
	'nvim-treesitter/nvim-treesitter',
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" }, -- Lazy load when a file is opened
	config = function()
		local config = require('nvim-treesitter.configs')
		config.setup({
			auto_install = true,
			ensure_installed = {
				"bash", "c", "cpp", "diff", "git_config", "gitcommit", "gitignore", "json",
				"lua", "markdown", "markdown_inline", "nix", "python", "query", "regex",
				"toml", "vim", "vimdoc", "yaml"
			},
			highlight = { enable = true },
			indent = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<TAB>",
					node_decremental = "<BS>",
				},
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ap"] = "@parameter.outer",
						["ip"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
			},
		})
	end

}
