return {
	-- Maintained fork of the archived epwalsh/obsidian.nvim
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- Load obsidian.nvim only for markdown files in the vault
	event = {
		"BufReadPre /home/frank/projects/notas/**.md",
		"BufNewFile /home/frank/projects/notas/**.md",
	},

	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},

	-- All plugin options must be in `opts`. lazy.nvim ignores other keys.
	opts = {
		-- Use the new `:Obsidian <subcommand>` commands only
		legacy_commands = false,

		workspaces = {
			{
				name = "notas",
				path = "~/projects/notas",
			},
		},

		-- Completion comes from the built-in obsidian-ls LSP server (nvim_lsp source in nvim-cmp)
		completion = {
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},

		-- <CR> on a link follows the link (default `smart_action` mapping of the fork).

		attachments = {
			-- The folder for images from `:Obsidian paste_img`, relative to the vault root.
			folder = "_attachment",
			-- Insert pasted images as markdown links with the vault-relative path.
			---@param path obsidian.Path the absolute path to the image file
			---@return string
			img_text_func = function(path)
				local rel = path:vault_relative_path() or path
				return string.format("![%s](%s)", path.name, rel)
			end,
		},

		picker = {
			-- Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
			name = "telescope.nvim",
			-- Defaults: <C-x> new note from the query, <C-l> insert a link to the selected note.
		},

		-- render-markdown.nvim draws headings, checkboxes, bullets and links.
		-- Disable the obsidian UI so the two plugins do not draw the same elements.
		ui = {
			enable = false,
		},
	},
}
