return {
	{
		"mfussenegger/nvim-dap",

		config = function()
			require("dap-python").setup("~/.config/python-env/bin/python")
			vim.keymap.set("n", "<F5>", ':lua require"dap".continue()<CR>')
			vim.keymap.set("n", "<F10>", ':lua require"dap".step_over()<CR>')
			vim.keymap.set("n", "<F11>", ':lua require"dap".step_into()<CR>')
			vim.keymap.set("n", "<F12>", ':lua require"dap".step_out()<CR>')
			vim.keymap.set("n", "<leader>b", ':lua require"dap".toggle_breakpoint()<CR>')
			vim.keymap.set(
				"n",
				"<leader>B",
				':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>'
			)
			vim.keymap.set(
				"n",
				"<leader>lp",
				':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>'
			)
			vim.keymap.set("n", "<leader>dr", ':lua require"dap".repl.open()<CR>')
			-- vim.keymap.set('n' , '<leader>dn', ':lua require("dap-python").test_method()<CR>')
			-- vim.keymap.set('n', '<leader>df', ':lua require("dap-python").test_class()<CR>')
			-- vim.keymap.set('n', '<leader>ds', ':lua require("dap-python").debug_selection()<CR>')
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		config = function()
			require("dap-python").setup("~/.config/python-env/bin/python")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()

			-- function to automatically start dap-ui once the debugger is started
			local dap, dapui = require("dap"), require("dapui")
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
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
