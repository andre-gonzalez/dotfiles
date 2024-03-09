return {

	{
		"williamboman/mason.nvim",

		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",

		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"sqlls",
					"ansiblels",
					"bashls",
					"yamlls",
					"terraformls",
					"jsonls",
					"grammarly",
					"marksman",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					-- Disable underline, it's very annoying
					underline = false,
				})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.sqlls.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})
			lspconfig.marksman.setup({
				capabilities = capabilities,
			})
			lspconfig.grammarly.setup({
				capabilities = capabilities,
			})

			lspconfig.ansiblels.setup({
				capabilities = capabilities,
				cmd = { "ansible-language-server", "--stdio" },
				filetype = { "yaml.ansible" },
				settings = {
					ansible = {
						ansible = {
							path = "ansible",
						},
						ansibleLint = {
							enabled = true,
							path = "ansible-lint",
						},
						executionEnvironment = {
							enabled = false,
						},
						python = {
							interpreterPath = "python",
						},
					},
				},
				-- To ansible LSP work
				vim.keymap.set("n", "<leader>af", ":set ft=yaml.ansible<CR>"),
			})

			vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			-- vim.keymap.set('n', '<C-y>', vim.lsp.diagnostic.goto_prev, {})
			-- vim.keymap.set('n', '<C-p>', vim.lsp.diagnostic.goto_next, {})
			-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
			-- vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
		end,
	},
}
