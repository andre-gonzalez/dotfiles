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
			"lua", "python", "sql", "yaml", "sh", "json", "terraform", "markdown",
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
					"grammarly",
					"marksman",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		ft = {
			"lua", "python", "sql", "yaml", "sh", "json", "terraform", "markdown",
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
				-- vim.keymap.set('n', '<C-y>', vim.lsp.diagnostic.goto_prev, {})
				-- vim.keymap.set('n', '<C-p>', vim.lsp.diagnostic.goto_next, {})
				-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
				-- vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
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
				grammarly = {},
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
			}

			for name, config in pairs(servers) do
				config.capabilities = capabilities
				config.on_attach = on_attach
				lspconfig[name].setup(config)
			end

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
		end,
	},
}
