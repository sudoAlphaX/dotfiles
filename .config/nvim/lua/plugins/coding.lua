return {
	"numToStr/Comment.nvim",
	keys = {
		{ "<C-/>", "<ESC><CMD>lua require('Comment.api').toggle.linewise.current()<CR>", mode = { "n" } },
		{ "<C-/>", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", mode = { "v" } },
	},
	lazy = true,
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local configs = require("gitsigns")
			configs.setup({
				current_line_blame = true,
				numhl = true,
			})
		end,
	},
}
