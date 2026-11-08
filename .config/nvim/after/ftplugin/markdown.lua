-- Settings for easier reading of markdown files.
-- Use ]] and [[ (built-in markdown ftplugin) to go to the next/previous heading.
local o = vim.opt_local

o.wrap = true -- wrap long lines
o.linebreak = true -- break at words, not in the middle of a word
o.breakindent = true -- wrapped lines keep the list indent
o.conceallevel = 2 -- hide markup (needed by obsidian.nvim and render-markdown.nvim)
o.colorcolumn = ""
o.spell = true
o.spelllang = { "en", "pt" }
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99 -- open all folds at start; use za / zc on a heading

-- With wrap, move by screen line
vim.keymap.set("n", "j", "gj", { buffer = true })
vim.keymap.set("n", "k", "gk", { buffer = true })

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
	.. "|setl wrap< linebreak< breakindent< conceallevel< colorcolumn< spell< spelllang< foldmethod< foldexpr< foldlevel<"
	.. "|sil! nunmap <buffer> j|sil! nunmap <buffer> k"
