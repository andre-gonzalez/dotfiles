local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

--- Plugins installation
return packer.startup(function(use)
		use { "wbthomason/packer.nvim"}

		-- Better markdown highlight and some keybinds to make easier to edit markdown files
		use {"gabrielelana/vim-markdown"}

		--Set a infomative line in the bottom of the editor
		use {"vim-airline/vim-airline"}

		--Themes for airline
		use {"vim-airline/vim-airline-themes"}

		-- Enable git commands direct from vim (I use to show the
		-- branch in vim-airline)
		use {"tpope/vim-fugitive"}

		--Plugin to show + and - git signs in the text file
		use {"airblade/vim-gitgutter"}

		-- Enable line in the indent
		use {"Yggdroot/indentLine"}

		-- Enable vim arround keybinds like ca'"
		use {"tpope/vim-surround"}

		use {"rentalcustard/exuberant-ctags"}

		--vim in the brownser
		-- use 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }

		-- telescope requirements (fuzzy finder in vim)
		use {"nvim-treesitter/nvim-treesitter"}
		use {"nvim-lua/popup.nvim"}
		use {"nvim-lua/plenary.nvim"}
		use {"nvim-telescope/telescope.nvim"}
		use {"nvim-telescope/telescope-fzy-native.nvim"}
		use {"nvim-telescope/telescope-file-browser.nvim"}

		--LSP for having language servers
		use {"neovim/nvim-lspconfig"}
		--To enable auto completion
		use {"hrsh7th/nvim-compe"}

		--Tree sitter. Do not need the nvim-treesitter because it was already installed in the
		--telescope requirements
		use {"nvim-treesitter/playground"}

		-- enable jupyter notebook inside vim
		-- use 'untitled-ai/jupyter_ascending.vim'

		--Indentation script for python
		use {"vim-scripts/indentpython.vim"}

		--Code folding for python
		use {"tmhedberg/SimpylFold"}

		--Comment in a vim like way
		use {"tpope/vim-commentary"}

		--fish syntax highlight
		use {"dag/vim-fish"}

		--csv viewer
		use {"chrisbra/csv.vim"}

		--terraform plugins
		use {"hashivim/vim-terraform"}

		--Database plugins
		use {"tpope/vim-dadbod"}
		use {"kristijanhusak/vim-dadbod-ui"}
		use {"kristijanhusak/vim-dadbod-completion"}

		--Plugin that i use with ipython
		use {"jpalardy/vim-slime"}

		--instant markdown visualizer
		-- use 'instant-markdown/vim-instant-markdown'
		--
		--base 16 colorschemes
		use {"RRethy/nvim-base16"}

		--Harpoon to move between files rapidly
		use {"nvim-lua/plenary.nvim"} -- don't forget to add this one if you don't have it yet!
		use {"ThePrimeagen/harpoon"}


		-- Change to work directory
		use {"airblade/vim-rooter"}

		-- Context freeze functions to the first line
		use {"wellle/context.vim"}

		--Buffer line
		use {"kyazdani42/nvim-web-devicons"}
		use {"akinsho/bufferline.nvim"}, { 'tag': 'v2.*' }
		set termguicolors

		-- Make neovim start faster
		-- use 'lewis6991/impatient.nvim'
