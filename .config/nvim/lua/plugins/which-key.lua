return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")
		wk.register({
			["<leader>"] = {
				g = "+git",
				f = "+file",
				b = "+buffers",
				l = "+lsp",
				w = "+diagostics",
				t = "+terminal"
			},
		})
	end,
}
