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
		opts = {
			disable_when_zoomed = true,
		},
		lazy = true,
	},
	{
		"declancm/maximize.nvim",
		keys = {
			{ "<leader>z", "<CMD>lua require('maximize').toggle()<CR>", desc = "Maximize/Minimize Split" },
		},
		lazy = true,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			view = { side = "right" },
		},
		keys = {
			{ "<C-n>", "<CMD>lua require('nvim-tree.api').tree.toggle()<CR>" },
			{ "<leader>e", "<CMD>lua require('nvim-tree.api').tree.focus()<CR>", { desc = "Focus File Tree" } },
		},
		config = true,
	},
}
