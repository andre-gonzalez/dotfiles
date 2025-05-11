return {
  "f-person/git-blame.nvim",
  cmd = "GitBlameToggle",  -- Lazy-load when the :GitBlameToggle command is used
  keys = {
    { "<leader>,", ":GitBlameToggle<CR>", desc = "Toggle Git Blame" },  -- Lazy-load on keybinding
  },
  config = function()
    require("gitblame").setup({
      enabled = false,  -- Keep it initially disabled
    })
  end,
}
