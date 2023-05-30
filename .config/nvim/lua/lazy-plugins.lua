------------------------------------------------------------------------------
----------------------------- PLUGINS ----------------------------------------
------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  "tpope/vim-surround",
	"nvim-lualine/lualine.nvim",
  "tpope/vim-fugitive",
  "airblade/vim-gitgutter",
  "Yggdroot/indentLine",
  "tpope/vim-surround",
  "nvim-treesitter/nvim-treesitter",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  "nvim-telescope/telescope-fzy-native.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-compe",
  "nvim-treesitter/playground",
  "vim-scripts/indentpython.vim",
  "terrortylor/nvim-comment",
  "chrisbra/csv.vim",
  "hashivim/vim-terraform",
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  "kristijanhusak/vim-dadbod-completion",
  "jpalardy/vim-slime",
  "RRethy/nvim-base16",
  "ThePrimeagen/harpoon",
  "airblade/vim-rooter",
  "kyazdani42/nvim-web-devicons",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "Exafunction/codeium.vim",
  "nvim-treesitter/nvim-treesitter-context",
  "folke/zen-mode.nvim",
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-dap-python",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
	"EdenEast/nightfox.nvim",
{
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
        require("lazy").load({ plugins = "firenvim", wait = true })
        vim.fn["firenvim#install"](0)
    end
},
  'akinsho/bufferline.nvim',
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }
})
