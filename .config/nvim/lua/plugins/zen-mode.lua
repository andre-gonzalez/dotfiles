return {

	"folke/zen-mode.nvim",

	config = function()
		vim.keymap.set("n", "<leader>zz", function()
			require("zen-mode").setup {
				window = {
					width = 200,
					options = {}
				},

				on_open = function(_)
					vim.fn.system([[tmux set status off]])
					vim.fn.system(
						[[tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z]])
				end,
				on_close = function(_)
					vim.fn.system([[tmux set status on]])
					vim.fn.system(
						[[tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z]])
				end
			}
			plugins = {
				gitsigns = { enabled = false }
			}

			require("zen-mode").toggle()
		end)
	end

}
