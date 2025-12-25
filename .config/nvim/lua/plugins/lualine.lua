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
			},
			sections = {
				lualine_a = {
					{
						'mode',
						icons_enabled = false,
					}
				},
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { 'filename' },
				lualine_x = { 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {}
			}
		})
	end
}
