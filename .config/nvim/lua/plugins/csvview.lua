-- Aligned columns for CSV/TSV files (virtual text: the file does not change).
return {
	"hat0uma/csvview.nvim",
	ft = { "csv", "tsv" },
	cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle", "CsvViewInfo" },
	opts = {
		parser = { comments = { "#", "//" } },
		view = {
			display_mode = "border", -- "│" between columns; "highlight" colors the delimiters only
			header_lnum = true, -- detect the header line automatically
			sticky_header = { enabled = true }, -- header stays at the top when you scroll down
			sticky_columns = { enabled = true, count = 1 }, -- first column stays when you scroll right
		},
		keymaps = {
			textobject_field_inner = { "if", mode = { "o", "x" } }, -- for example: cif, dif, vif
			textobject_field_outer = { "af", mode = { "o", "x" } },
			jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
			jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
			jump_next_row = { "<Enter>", mode = { "n", "v" } },
			-- st does not send <S-Enter> (needs CSI-u), so use <BS> for the previous row
			jump_prev_row = { "<BS>", mode = { "n", "v" } },
		},
	},
	keys = {
		{ "<leader>cv", "<cmd>CsvViewToggle<cr>", ft = { "csv", "tsv" }, desc = "Toggle CSV view" },
	},
	config = function(_, opts)
		local csvview = require("csvview")
		csvview.setup(opts)

		-- Enable the view automatically. The plugin loads on the first CSV/TSV
		-- FileType event, so also enable it for the buffers that are already open.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("csvview_auto", { clear = true }),
			pattern = { "csv", "tsv" },
			callback = function(args)
				if not csvview.is_enabled(args.buf) then
					csvview.enable(args.buf)
				end
			end,
		})
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) and vim.tbl_contains({ "csv", "tsv" }, vim.bo[buf].filetype) then
				if not csvview.is_enabled(buf) then
					csvview.enable(buf)
				end
			end
		end
	end,
}
