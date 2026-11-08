-- Settings for easier reading of CSV files (also used for TSV: after/ftplugin/tsv.lua).
-- csvview.nvim aligns the columns (lua/plugins/csvview.lua).
local o = vim.opt_local

o.wrap = false -- one row on one screen line
o.spell = false
o.colorcolumn = ""
o.cursorline = true -- shows the current row across the aligned columns
o.sidescrolloff = 8

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "") .. "|setl wrap< spell< colorcolumn< cursorline< sidescrolloff<"
