return {
	{
		"folke/trouble.nvim",
		branch = "dev",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local configs = require("trouble")
			configs.setup()
			vim.keymap.set("n", "<leader>ww", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Project Diagnostics" })
			vim.keymap.set(
				"n",
				"<leader>wc",
				"<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
				{ desc = "Buffer Diagnostics" }
			)
			vim.keymap.set("n", "<leader>wh", vim.diagnostic.open_float, { desc = "View Diagnostic" })
			vim.keymap.set("n", "<leader>wn", vim.diagnostic.goto_next, { desc = "Goto Next Diagnostic" })
			vim.keymap.set("n", "<leader>wb", vim.diagnostic.goto_prev, { desc = "Goto Prev Diagnostic" })
			vim.keymap.set("n", "<leader>wq", "<CMD>Trouble quickfix toggle<CR>", { desc = "Quickfix List" })
			vim.keymap.set("n", "<leader>wl", "<CMD>Trouble loclist toggle<CR>", { desc = "Location List" })
			-- vim.keymap.set("n", "<leader>wk", vim.diagnostic.setloclist, { desc = "List Diagnostics" })
		end,
	},
}
