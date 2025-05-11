return {

  "jpalardy/vim-slime",

  keys = { "<leader>y" },  -- Lazy load when <leader>ss is pressed

  config = function()
    vim.g.slime_target = "tmux"  -- Configure the target for vim-slime (tmux)
  end,

}
