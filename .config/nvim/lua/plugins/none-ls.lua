return {
	"nvimtools/none-ls.nvim",
	event = "LspAttach",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Formatters
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.markdownlint,
				null_ls.builtins.formatting.yamlfmt,
				null_ls.builtins.formatting.sql_formatter,
				null_ls.builtins.formatting.nixpkgs_fmt,
				-- null_ls.builtins.formatting.sqlfmt,

				-- Diagnostics
				-- null_ls.builtins.diagnostics.sqlfluff.with({
				--   extra_args = { "--dialect", "postgres" }, -- customize dialect
				-- }),

				-- Completion
				null_ls.builtins.completion.spell,
			},

			vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format with LSP" })

		})
	end,
}
