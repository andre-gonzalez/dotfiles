return {

	"nvimtools/none-ls.nvim",

	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.markdownlint,
				null_ls.builtins.formatting.yamlfmt,
				-- null_ls.builtins.formatting.sqlfmt,
				null_ls.builtins.formatting.sql_formatter,
				null_ls.builtins.completion.spell,
				-- null_ls.builtins.diagnostics.sqlfluff.with({
				-- 		extra_args = { "--dialect", "postgres" }, -- change to your dialect
				-- }),
			},
		})

		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
	end,
}
