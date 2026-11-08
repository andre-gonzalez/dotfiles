return {
  "shortcuts/no-neck-pain.nvim",
  ft = { "newsboat", "markdown" },
  keys = {
    { "<leader>nn", "<cmd>NoNeckPain<cr>", desc = "Toggle centered window" },
  },
  opts = {
    width = 100, -- or whatever feels good for your terminal width
  },
}
