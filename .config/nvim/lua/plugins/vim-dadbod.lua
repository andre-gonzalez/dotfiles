return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		keys = {
			{ "<leader>db", "<cmd>DBUIToggle<CR>", desc = "Toggle DB UI" },
			{ "<leader>bf", "<cmd>DBUIFindBuffer<CR>", desc = "Find DB buffer" },
		},
		config = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

			-- Credentials are stored in lua/secrets.lua (gitignored).
			-- Copy lua/secrets.lua.example to lua/secrets.lua and fill in your values.
			local ok, secrets = pcall(require, "secrets")
			vim.g.dbs = {
				{
					name = "developers-interactive-warehouse",
					url = ok and secrets.databricks_url or "",
				},
			}
		end,
	},
}
