return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local configs = require("gitsigns")
		vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
		vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
		vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
		vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>", { desc = "Find Git Files" })
		configs.setup({
			numhl = true,
		})
	end,
}
