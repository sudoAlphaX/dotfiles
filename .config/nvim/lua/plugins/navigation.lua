return {
	{
		"alexghergh/nvim-tmux-navigation",
		keys = {

			{ "<C-h>", "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateLeft()<CR>", mode = { "n", "t" } },
			{ "<C-j>", "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateDown()<CR>", mode = { "n", "t" } },
			{ "<C-k>", "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateUp()<CR>", mode = { "n", "t" } },
			{ "<C-l>", "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateRight()<CR>", mode = { "n", "t" } },
			{
				"<C-Tab>",
				"<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateLastActive()<CR>",
				mode = { "n", "t" },
			},
		},
		lazy = true,
	},
}
