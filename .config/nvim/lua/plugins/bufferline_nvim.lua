return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local configs = require("bufferline")
		configs.setup()
		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
	end,
}
