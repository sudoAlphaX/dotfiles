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
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = true,
		keys = {
			-- Find Files
			{ "<leader> ", "<CMD>lua require('telescope.builtin').find_files()<CR>", { desc = "Open File" } },
			{ "<leader>o", "<CMD>lua require('telescope.builtin').git_files()<CR>", { desc = "Git Files" } },
			{ "<leader>r", "<CMD>lua require('telescope.builtin').oldfiles()<CR>", { desc = "Recent Files" } },
			{ "<leader>/", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { desc = "Live Grep" } },

			-- Buffers
			{ "<leader>bb", "<CMD>lua require('telescope.builtin').buffers()<CR>", { desc = "List Buffers" } },

			{ "<leader>p", "<CMD>lua require('telescope.builtin').registers()<CR>", { desc = "List Registers" } },

			-- Git
			{ "<leader>gc", "<CMD>lua require('telescope.builtin').git_commits()<CR>", { desc = "Git Commits" } },
			{ "<leader>gb", "<CMD>lua require('telescope.builtin').git_branches()<CR>", { desc = "Git Branches" } },
			{ "<leader>gs", "<CMD>lua require('telescope.builtin').git_status()<CR>", { desc = "Git Status" } },
			{ "<leader>gh", "<CMD>lua require('telescope.builtin').git_stash()<CR>", { desc = "Git Stashes" } },
		},
	},
}
