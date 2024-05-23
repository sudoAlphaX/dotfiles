return {
	"numToStr/Comment.nvim",
	config = function()
		local configs = require("Comment")
		configs.setup()
		local api = require("Comment.api")
		vim.keymap.set("n", "<C-/>", api.toggle.linewise.current)
		vim.keymap.set("x", "<C-/>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
	end,
}
