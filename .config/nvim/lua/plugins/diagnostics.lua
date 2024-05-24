return {
	{
		"folke/trouble.nvim",
		branch = "dev",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local configs = require("trouble")
			configs.setup()
			vim.keymap.set("n", "<leader>tt", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Project Diagnostics" })
			vim.keymap.set(
				"n",
				"<leader>tb",
				"<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
				{ desc = "Buffer Diagnostics" }
			)
			vim.keymap.set("n", "<leader>tq", "<CMD>Trouble quickfix toggle<CR>", { desc = "Quickfix List" })
			vim.keymap.set("n", "<leader>tl", "<CMD>Trouble loclist toggle<CR>", { desc = "Location List" })
		end,
	},
}
