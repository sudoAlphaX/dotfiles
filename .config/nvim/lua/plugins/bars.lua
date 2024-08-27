return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { "filename" },
					lualine_x = { "diagnostics" },
					lualine_y = { "searchcount", "selectioncount", { "location", separator = "" }, { "progress" } },
					lualine_z = { { "datetime", style = "%H:%M" } },
				},
			})
		end,
	},
}
