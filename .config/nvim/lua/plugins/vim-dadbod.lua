return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = { "sql", "mysql", "plsql" },
				lazy = true,
				-- vim-dadbod must load with the completion plugin: its fetch calls
				-- db#resolve, which errors if only the ft trigger fired (dadbod is
				-- otherwise only pulled in when DBUI opens).
				dependencies = { "tpope/vim-dadbod" },
				config = function()
					-- Install the databricks scheme override (defined in
					-- after/plugin/databricks_completion.vim) before the plugin's
					-- FileType autocmd fetches and caches the connection's scheme.
					if vim.fn.exists("*DatabricksCompletionInstall") == 1 then
						vim.fn.DatabricksCompletionInstall()
					end
				end,
			},
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		keys = {
			{ "<leader>db", "<cmd>DBUIToggle<CR>", desc = "Toggle DB UI" },
			{
				"<leader>bf",
				-- DBUIFindBuffer unconditionally opens the drawer; close it
				-- afterwards unless it was already open.
				function()
					local function drawer_win()
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "dbui" then
								return win
							end
						end
					end
					local was_open = drawer_win() ~= nil
					vim.cmd("DBUIFindBuffer")
					if not was_open then
						local win = drawer_win()
						if win then
							vim.api.nvim_win_close(win, false)
						end
					end
				end,
				desc = "Find DB buffer",
			},
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
				{
					name = "Local SEO Dev",
					url = ok and secrets.local_seo_dev or "",
				},
				-- {
				-- 	name = "Data SDK Dev",
				-- 	url = ok and secrets.data_sdk_dev or "",
				-- },
			}
		end,
	},
}
