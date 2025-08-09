return {
	"nvimtools/none-ls.nvim",
	event = "LspAttach",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Formatters
				-- Python
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				{
					name = "pyproject-fmt",
					method = null_ls.methods.FORMATTING,
					filetypes = { "toml" },
					generator = null_ls.generator({
						command = "pyproject-fmt",
						args = { "-" },
						to_stdin = true,
						from_stderr = false,
						format = "raw",
					}),
					condition = function(params)
						-- Get only the filename (no path)
						return vim.fn.fnamemodify(params.bufname, ":t") == "pyproject.toml"
					end,
				},
				-- null_ls.builtins.diagnostics.ruff,
				-- null_ls.builtins.formatting.ruff,
				null_ls.builtins.diagnostics.mypy,
				-- null_ls.builtins.formatting.docformatter,

				null_ls.builtins.formatting.prettier,
				-- Lua
				null_ls.builtins.formatting.stylua,
				-- Yaml
				null_ls.builtins.formatting.yamlfmt,
				-- SQL
				null_ls.builtins.formatting.sql_formatter,
				-- Nix
				null_ls.builtins.formatting.nixpkgs_fmt.with({
					filetypes = { "nix" },
				}),
				null_ls.builtins.formatting.nixfmt.with({
					filetypes = { "nix" },
				}),
				-- Shell
				null_ls.builtins.formatting.shfmt,

				-- Diagnostics
				-- Generic
				null_ls.builtins.diagnostics.codespell.with({
					filetypes = {
						"lua",
						"python",
						"sql",
						"yaml",
						"sh",
						"terraform",
						"yaml.ansible",
						"dockerfile",
						"nix",
						"beancount",
					},
				}),
				-- null_ls.builtins.diagnostics.misspell,
				-- null_ls.builtins.diagnostics.typos,
				-- Ansible
				null_ls.builtins.diagnostics.ansiblelint.with({
					filetypes = { "yaml.ansible" },
				}),
				-- Markdown
				null_ls.builtins.diagnostics.markdownlint,
				-- Terraform
				null_ls.builtins.diagnostics.tfsec,
				-- Docker
				null_ls.builtins.diagnostics.hadolint,
				-- null_ls.builtins.diagnostics.sqlfluff.with({
				--   extra_args = { "--dialect", "postgres" }, -- customize dialect
				-- }),

				-- Completion
				null_ls.builtins.completion.spell,
			},

			vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format with LSP" }),
		})
	end,
}
