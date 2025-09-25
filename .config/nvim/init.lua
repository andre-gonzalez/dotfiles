if vim.g.vscode then
	-- VSCode Neovim
	require("vscode-base")
	require("vscode-remaps")
else
	-- Ordinary Neovim
	require("base")
	require("remaps")
	require("lazy-plugins")
	require("abbreviations")
end
