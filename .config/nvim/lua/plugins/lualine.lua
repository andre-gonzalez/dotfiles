return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		local colors = {
			fg = "#838994",
			bg = "#1E1E2E",
		}
		require('lualine').setup({
			options = {
				theme = {
					normal = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.fg, bg = colors.bg },
					},
					insert = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
					},
					visual = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
					},
					command = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
					},
					replace = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
					},
					inactive = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.fg, bg = colors.bg },
					},
				}
			}
		})
	end
}
