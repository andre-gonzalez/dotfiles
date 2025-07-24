return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		ft = {
			"lua",
			"python",
			"sql",
			"yaml",
			"sh",
			"json",
			"terraform",
			"markdown",
			"yaml.ansible",
			"dockerfile",
			"nix",
			"beancount",
		},
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
					"marksman",
					"stylua",
					"dockerls",
					"rnix",
					"beancount",
					"ruff",
					-- "snyk_ls",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		ft = {
			"lua",
			"python",
			"sql",
			"yaml",
			"sh",
			"json",
			"terraform",
			"markdown",
			"yaml.ansible",
			"dockerfile",
			"nix",
			"beancount",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr }
				vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<C-y>", vim.diagnostic.goto_prev, {})
				vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_next, {})
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			end

			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					underline = false,
				})

			local servers = {
				lua_ls = {},
				pyright = {},
				sqlls = {},
				bashls = {},
				yamlls = {},
				jsonls = {},
				terraformls = {},
				marksman = {},
				ansiblels = {
					cmd = { "ansible-language-server", "--stdio" },
					filetype = { "yaml.ansible" },
					settings = {
						ansible = {
							ansible = { path = "ansible" },
							ansibleLint = { enabled = true, path = "ansible-lint" },
							executionEnvironment = { enabled = false },
							python = { interpreterPath = "python" },
						},
					},
				},
				rnix = {},
				beancount = {},
				-- snyk_ls = {},
			}

			for name, config in pairs(servers) do
				config.capabilities = capabilities
				config.on_attach = on_attach
				lspconfig[name].setup(config)
			end

			-- -- Manual setup for ltex-ls-plus
			-- lspconfig.ltex_plus.setup({
			-- 	cmd = { "ltex-ls-plus" },
			-- 	filetypes = { "markdown", "tex", "text" },
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	settings = {
			-- 		ltex = {
			-- 			language = "en-US",
			-- 			additionalLanguages = { "pt-BR" },
			-- 			checkFrequency = "save",
			-- 			disabledRules = {
			-- 				["en-US"] = {},
			-- 				["pt-BR"] = {},
			-- 			},
			-- 		},
			-- 	},
			-- })

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local bufnr = args.buf
					local root_dir = client and client.config and client.config.root_dir

					if root_dir then
						vim.cmd("cd " .. root_dir)
					end
				end,
			})

			-- Keymaps to manually switch ltex language
			-- vim.keymap.set("n", "<leader>le", function()
			-- 	for _, client in pairs(vim.lsp.get_clients()) do
			-- 		if client.name == "ltex" then
			-- 			client.config.settings.ltex.language = "en-US"
			-- 			client.notify("workspace/didChangeConfiguration", {
			-- 				settings = client.config.settings,
			-- 			})
			-- 		end
			-- 	end
			-- 	print("Switched ltex language to en-US")
			-- end, { desc = "LTeX: Switch to English" })
			--
			-- vim.keymap.set("n", "<leader>lp", function()
			-- 	for _, client in pairs(vim.lsp.get_clients()) do
			-- 		if client.name == "ltex_plus" then
			-- 			client.config.settings.ltex.language = "pt-BR"
			-- 			client.notify("workspace/didChangeConfiguration", {
			-- 				settings = client.config.settings,
			-- 			})
			-- 			client.stop()
			-- 			vim.defer_fn(function()
			-- 				vim.cmd("edit")
			-- 			end, 100)
			-- 		end
			-- 	end
			-- 	print("Switched ltex language to pt-BR and restarted LSP")
			-- end, { desc = "LTeX: Switch to Portuguese" })
		end,
	},
}
