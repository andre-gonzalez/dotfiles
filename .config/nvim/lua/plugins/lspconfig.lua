-- On NixOS, the nix_os flake (homeManager.neovim / nixos.neovim) installs the
-- language servers. Mason cannot install most of them there: its prebuilt
-- binaries need nix-ld, and some packages build with cargo. So on NixOS Mason
-- installs only sqlls (npm, not in nixpkgs), and its bin goes at the end of
-- PATH, so that the Nix servers come first.
local is_nixos = vim.uv.fs_stat("/etc/NIXOS") ~= nil

local mason_servers = {
	"lua_ls",
	"pyright",
	"sqlls",
	"ansiblels",
	"bashls",
	"yamlls",
	"terraformls",
	"jsonls",
	-- "marksman",
	"stylua",
	"dockerls",
	"nil_ls",
	"beancount",
	"ruff",
	-- "snyk_ls",
}
if is_nixos then
	mason_servers = { "sqlls" }
end

return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		config = function()
			require("mason").setup({
				PATH = is_nixos and "append" or "prepend",
			})
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
				ensure_installed = mason_servers,
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
				-- marksman = {},
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
				nil_ls = {},
				beancount = {},
				ruff = {},
				dockerls = {},
				-- snyk_ls = {},
				docker_compose_language_service = {
					filetypes = { "yaml" }, -- still runs on YAML but we filter below
					on_new_config = function(new_config, root_dir)
						-- Only attach to docker-compose files
						local fname = vim.api.nvim_buf_get_name(0)
						local function is_docker_compose(name)
							return name:match("docker%-compose%.yml$")
								or name:match("docker%-compose%.yaml$")
								or name:match("compose%.yml$")
								or name:match("compose%.yaml$")
								or name:match("%compose.yaml$")
						end
						if not is_docker_compose(fname) then
							-- prevent LSP from starting
							new_config.cmd = { "false" }
						end
					end,
					-- optional: capabilities, on_attach inherited from your setup
				},
			}

			for name, config in pairs(servers) do
				config.capabilities = capabilities
				config.on_attach = on_attach
				vim.lsp.config(name, config)
				vim.lsp.enable(name)
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
