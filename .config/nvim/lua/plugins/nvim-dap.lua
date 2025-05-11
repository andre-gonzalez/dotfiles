return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			"<F5>", "<F10>", "<F11>", "<F12>",
			"<leader>b", "<leader>B", "<leader>lp", "<leader>dr",
		},
		config = function()
			local dap = require("dap")

			-- Optionally trigger virtual text when DAP loads
			pcall(require, "nvim-dap-virtual-text")

			vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Set Conditional Breakpoint" })
			vim.keymap.set("n", "<leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "Set Log Point" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open DAP REPL" })

			-- Uncomment these if you want to enable them
			-- local dap_python = require("dap-python")
			-- vim.keymap.set('n', '<leader>dn', dap_python.test_method, { desc = "DAP Test Method" })
			-- vim.keymap.set('n', '<leader>df', dap_python.test_class, { desc = "DAP Test Class" })
			-- vim.keymap.set('n', '<leader>ds', dap_python.debug_selection, { desc = "DAP Debug Selection" })
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python", -- optionally lazy load only on Python files
		config = function()
			require("dap-python").setup("~/.config/python-env/bin/python")
		end,
	},

	{
		"nvim-neotest/nvim-nio",
		lazy = true,
	},

	{
		"rcarriga/nvim-dap-ui",
		lazy = true,                          -- tell Lazy to defer loading
		dependencies = { "mfussenegger/nvim-dap" }, -- ensure DAP is loaded first
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,

		-- Load only when dap is loaded (module-based lazy loading)
		module = "dapui",
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		module = "nvim-dap-virtual-text", -- module-based trigger
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
		dependencies = { "mfussenegger/nvim-dap" },
	},
}
