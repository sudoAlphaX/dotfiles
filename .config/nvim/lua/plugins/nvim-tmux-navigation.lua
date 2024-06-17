return {
	"alexghergh/nvim-tmux-navigation",
	config = function()
		local configs = require("nvim-tmux-navigation")

		configs.setup({
			disable_when_zoomed = true,
		})

		vim.keymap.set("n", "<C-h>", configs.NvimTmuxNavigateLeft)
		vim.keymap.set("n", "<C-j>", configs.NvimTmuxNavigateDown)
		vim.keymap.set("n", "<C-k>", configs.NvimTmuxNavigateUp)
		vim.keymap.set("n", "<C-l>", configs.NvimTmuxNavigateRight)
		vim.keymap.set("n", "<C-Tab>", configs.NvimTmuxNavigateLastActive)

		vim.keymap.set("t", "<C-h>", configs.NvimTmuxNavigateLeft)
		vim.keymap.set("t", "<C-j>", configs.NvimTmuxNavigateDown)
		vim.keymap.set("t", "<C-k>", configs.NvimTmuxNavigateUp)
		vim.keymap.set("t", "<C-l>", configs.NvimTmuxNavigateRight)
		vim.keymap.set("t", "<C-Tab>", configs.NvimTmuxNavigateLastActive)
		-- vim.keymap.set("n", "<C-Space>", configs.NvimTmuxNavigateNext)
	end,
}
