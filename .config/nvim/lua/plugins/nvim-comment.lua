return {
  "terrortylor/nvim-comment",
  keys = {
    "gcc",  -- Lazy-load the plugin when this keybinding is pressed
    "gc",   -- Lazy-load the plugin when this keybinding is pressed for visual mode
  },

  config = function()
    require('nvim_comment').setup{
      comment_empty = false,  -- Do not comment out empty lines
    }
  end,
}
