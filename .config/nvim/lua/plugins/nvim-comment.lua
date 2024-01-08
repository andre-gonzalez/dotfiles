return {

  "terrortylor/nvim-comment",

	config = function()
		require('nvim_comment').setup{
			-- should comment out empty or whitespace only lines
			comment_empty = false,
		}
	end

}
