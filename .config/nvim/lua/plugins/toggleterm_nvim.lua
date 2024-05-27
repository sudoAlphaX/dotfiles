return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local configs = require("toggleterm")
		configs.setup()
		vim.keymap.set("n", "<leader>tt", "<CMD>ToggleTerm direction=horizontal<CR>", { desc = "Terminal split" })
		vim.keymap.set("n", "<leader>tf", "<CMD>ToggleTerm direction=float<CR>", { desc = "Floating Terminal" })
		vim.keymap.set("n", "<leader>tb", "<CMD>ToggleTerm direction=tab<CR>", { desc = "Terminal in a Tab" })
		vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]])
	end,
}
