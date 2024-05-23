return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "bash", "gitignore", "json", "lua", "markdown", "python", "regex", "ini" },
			sync_install = true,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
