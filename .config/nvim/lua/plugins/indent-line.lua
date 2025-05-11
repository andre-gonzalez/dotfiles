return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- use ibl module as per v3
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
    },
    scope = {
      enabled = false, -- disables underline/highlighting of functions, blocks, etc.
    },
    whitespace = {
      remove_blankline_trail = true,
    },
  },
}
