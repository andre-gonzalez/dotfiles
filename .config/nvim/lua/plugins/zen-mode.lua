return {
  "folke/zen-mode.nvim",

  keys = {
    {
      "<leader>zz",
      function()
        require("zen-mode").toggle()
      end,
      desc = "Toggle Zen Mode"
    },
  },

  config = function()
    require("zen-mode").setup({
      window = {
        -- Narrow window for prose, wide window for code
        width = function()
          return vim.bo.filetype == "markdown" and 100 or 200
        end,
        options = {},
      },
      plugins = {
        gitsigns = { enabled = false },
      },
      on_open = function()
        vim.opt.colorcolumn = ""
        vim.fn.system([[tmux set status off]])
        vim.fn.system([[tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z]])
      end,
      on_close = function()
        vim.opt.colorcolumn = "79"
        vim.fn.system([[tmux set status on]])
        vim.fn.system([[tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z]])
      end,
    })
  end,
}
