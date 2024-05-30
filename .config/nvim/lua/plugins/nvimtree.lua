return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({})
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.opt.termguicolors = true


		local configs = require("nvim-tree.api")
		vim.keymap.set("n", "<C-n>", configs.tree.toggle)
		vim.keymap.set("n", "<leader>e", configs.tree.focus, { desc = "Focus File Tree" })
	end,
}
